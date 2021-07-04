package com.xgkx.procurement.service.serviceimpl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.configuration.FilePathPropreties;
import com.xgkx.procurement.entity.*;
import com.xgkx.procurement.mapper.DemandMapper;
import com.xgkx.procurement.service.*;
import com.xgkx.procurement.util.DateTimeUtils;
import com.xgkx.procurement.util.ExcelUtil;
import com.xgkx.procurement.util.ItexUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename DemandServiceImpl
 * @date 2021/4/27 16:39
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class DemandServiceImpl extends ServiceImpl<DemandMapper, Demand> implements DemandService {

    @Autowired
    private UserSerivce userSerivce;
    @Autowired
    private BathService bathService;
    @Autowired
    private OrgService orgService;
    @Autowired
    private ItemService itemService;
    @Autowired
    private UnitService unitService;
    @Autowired
    private ProcurementService procurementService;
    @Autowired
    private FilePathPropreties filePathPropreties;


    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R submitDemand(Demand demand) {
        Bath bath = bathService.getById(demand.getBathId());
        if (bath.getReportStartTime().isAfter(DateTimeUtils.getCurrentLocalDateTime())) {
            // 批次还没有开始
            return R.error("批次还没有开始，不允许提交需求");
        }
        if (bath.getReportStopTime().isBefore(DateTimeUtils.getCurrentLocalDateTime())) {
            // 批次已经结束
            return R.error("批次已经结束，请等待下一批");
        }
        // 查看在当前批次中，是否已经提交这个需求，如果已经存在，则数量相加
        QueryWrapper<Demand> wrapper = new QueryWrapper<>();
        wrapper.eq("org_id", demand.getOrgId())
                .eq("item_id", demand.getItemId())
                .eq("unit_id", demand.getUnitId())
                .eq("bath_id", demand.getBathId());
        Integer count = baseMapper.selectCount(wrapper);
        if (count > 0) {
            // 已经存在
            Demand demand1 = baseMapper.selectOne(wrapper);
            demand1.setCount(demand1.getCount() + demand.getCount());
            updateById(demand1);
            return R.ok().put("data", demand1);
        }
        save(demand);
        return R.ok().put("data", demand);
    }

    @Override
    public List<Demand> getMyOrgDemandList(String currentUserId, Integer bathId) {
//        User user = userSerivce.getById(currentUserId);
        List<Demand> demandList = baseMapper.getMyOrgDemandList(currentUserId, bathId);
        // 获取单价
        if (bathId != null) {
            // 只有一个批次的
            // 查询批次的购买信息
            List<Procurement> procurementList = procurementService.getListByBathId(bathId);
            // Map<物品id-单位id, 采购>
            Map<String, Procurement> proMap = procurementList.stream().collect(Collectors.toMap(item -> item.getItemId() + "-" + item.getUnitId(),
                    item -> item));
            for (Demand demand : demandList) {
                String key = demand.getItemId() + "-" + demand.getUnitId();
                // 设置单价与总价
                if (proMap.containsKey(key)) {
                    Procurement procurement = proMap.get(key);
                    // 单价
                    demand.setPrice(procurement.getPrice());
                    // 计算总价
                    BigDecimal totalPrice = procurement.getPrice().multiply(BigDecimal.valueOf(demand.getCount()));
                    demand.setTotalPrice(totalPrice);
                }
            }
        }
        return demandList;
    }

    @Override
    public List getList(Demand demand) {
        List<Demand> demandList = baseMapper.getList(demand);
        Set<Integer> orgIds = demandList.stream().map(Demand::getOrgId).collect(Collectors.toSet());
        List<Org> orgList = orgService.getListByOrgIds(new ArrayList<>(orgIds));
        Map<Integer, Org> orgMap = orgList.stream().collect(Collectors.toMap(Org::getOrgId, item -> item));
        for (Demand demand1 : demandList) {
            if (orgMap.containsKey(demand1.getOrgId())) {
                Org org = orgMap.get(demand1.getOrgId());
                demand1.setOrgName(org.getOrgName());
            } else {
                demand1.setOrgName("开发用户");
            }
        }
        return demandList;
    }

    @Override
    public Bath statisticsByBathId(Integer bathId, Integer orgId) {
        // 获取批次信息
        Bath bath = bathService.getById(bathId);
        // 获取本批次的所有需求
        Demand queryParams = new Demand();
        queryParams.setBathId(bathId);
        List<Demand> demandList = baseMapper.getList(queryParams);
        if (orgId != null) {
            // 如果orgId不为空，根据orgId过滤掉其他组织的需求
            demandList = demandList.stream().filter(item -> item.getOrgId().equals(orgId)).collect(Collectors.toList());
        }
        Map<String, Demand> result = new HashMap<>();
        for (Demand demand : demandList) {
            // 获取key
            String key =
                    new StringBuilder().append(demand.getItemId()).append("-").append(demand.getUnitId()).toString();
            // 判断有没有
            if (result.containsKey(key)) {
                // 存在，数量增加
                Demand item = result.get(key);
                item.setCount(item.getCount() + demand.getCount());
                result.put(key, item);
            } else {
                // 不存在，添加新值
                demand.setCreateBy(null);
                demand.setCreateTime(null);
                demand.setUpdateBy(null);
                demand.setUpdateTime(null);
                result.put(key, demand);
            }
        }
        // 获取当前批次中的采购信息
        List<Procurement> proList = procurementService.getListByBathId(bathId);
        Map<String, Procurement> proMap = proList.stream()
                .collect(Collectors.toMap(item ->
                        item.getItemId() + "-" + item.getUnitId(), item -> item));
        for (String key : result.keySet()) {
            Demand demand = result.get(key);
            if (proMap.containsKey(key)) {
                demand.setIsBuy(false);
            } else {
                // 没有购买
                demand.setIsBuy(true);
                // 查询是否有历史记录

            }
        }

        bath.setDemandList(result.values());
        return bath;
    }

    @Override
    public List<Demand> getListByBathId(Integer bathId) {
        QueryWrapper<Demand> wrapper = new QueryWrapper<>();
        wrapper.eq("bath_id", bathId);
        List<Demand> demandList = baseMapper.selectList(wrapper);
        return demandList;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R updateDemand(Demand demand) {
        Bath bath = bathService.getById(demand.getBathId());
        if (bath.getReportStopTime().isBefore(DateTimeUtils.getCurrentLocalDateTime())) {
            return R.error("已经停止上报，不允许修改");
        }
        if (demand.getIsMeet()) {
            return R.error("已经给予的需求不允许修改");
        }
        updateById(demand);
        return R.ok();
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R deleteDemand(Integer demandId) {
        Demand demand = getById(demandId);
        if (demand == null) {
            return R.error("请不要重复点击");
        }
        Bath bath = bathService.getById(demand.getBathId());
        if (bath.getReportStopTime().isBefore(DateTimeUtils.getCurrentLocalDateTime())) {
            return R.error("已经停止上报，不允许删除");
        }
        if (demand.getIsMeet()) {
            return R.error("已经给予的需求不允许删除");
        }
        removeById(demandId);
        return R.ok();
    }

    @Override
    public String exprotPdf (Integer bathId, JSONObject data, String currentUserId) throws IOException {
        Integer pageNum = 18;
        // 查询当前用户信息
        User user = userSerivce.getById(currentUserId);
        // 查询组织机构消息
        Org org = orgService.getById(user.getOrgId());
        // 获取批次信息
        Bath bath = bathService.getById(bathId);
        // 查询当前批次下的所有需求
        QueryWrapper<Demand> wrapper = new QueryWrapper<>();
        wrapper.eq("org_id", org.getOrgId());
        wrapper.eq("bath_id", bathId);
        List<Demand> demandList = baseMapper.selectList(wrapper);
        if (demandList == null || demandList.isEmpty()) {
            return "";
        }
        // 获取所有物品名称
        List<Integer> itemIdList = demandList.stream().map(Demand::getItemId).collect(Collectors.toList());
        List<Item> itemList = itemService.getListByIds(itemIdList);
        Map<Integer, Item> itemMap = itemList.stream().collect(Collectors.toMap(Item::getItemId, item -> item));
        // 获取所有单位名称
        List<Integer> unitIdList = demandList.stream().map(Demand::getUnitId).collect(Collectors.toList());
        List<Unit> unitList = unitService.getListByIds(unitIdList);
        Map<Integer, Unit> unitMap = unitList.stream().collect(Collectors.toMap(Unit::getUnitId, item -> item));
        // 计算文件个数  一个文件pageNum个
        Integer fileNum = demandList.size() % pageNum == 0 ? demandList.size() / pageNum : demandList.size() / pageNum + 1;
        List<String> filePaths = new ArrayList<>();
        // 对需求的循环
        // 循环导出
        for (int index = 0; index < fileNum; index++) {
            int i = (index * pageNum);
            // 设置导出数据集
            Map<String, String> exportData = new HashMap<>();
            // 组织机构名称
            if (data.getString("org_name") != null) {
                exportData.put("org_name", data.getString("org_name"));
            } else {
                exportData.put("org_name", org.getOrgName());
            }
            // 申请人
            if (data.getString("user_name") != null) {
                exportData.put("user_name", data.getString("user_name"));
            } else {
                exportData.put("user_name", user.getUserName());
            }
            // 联系电话
            if (data.getString("phone_num") != null) {
                exportData.put("phone_num", data.getString("phone_num"));
            } else {
                exportData.put("phone_num", user.getPhoneNum());
            }
            // 来源
            if (data.getString("source") != null) {
                exportData.put("source", data.getString("source"));
            }
            // 时间
            String time = DateTimeUtils.getCurrentDateTimeStr();
            exportData.put("time", time);
            // 办公用品内容：
            for (; i < demandList.size(); i++) {
                Demand demand = demandList.get(i);
                Item item = itemMap.get(demand.getItemId());
                if (exportData.containsKey("item_" + (i % pageNum + 1))) {
                    continue;
                }
                if (item != null) {
                    String name = item.getItemName();
                    String description = item.getItemDescription() == null ? "" : item.getItemDescription();
                    exportData.put("item_" + (i % pageNum + 1), name + " " + description);
                }
                Unit unit = unitMap.get(demand.getUnitId());
                if (unit != null) {
                    exportData.put("unit_" + (i % pageNum + 1), demand.getCount() + unit.getUnitName());
                }
            }
            String filePath = ItexUtils.exportToPdf(
                    filePathPropreties.getExportTemplateFilePath() + "item_template.pdf",
                    exportData,
                    org.getOrgName() + "-" + bath.getPathName() + "申购表-" + (index + 1)
            );
            filePaths.add(filePath);
        }
        if (filePaths.size() > 1) {
            // 大于一个文件，将文件合并
            String exportFilePath = ItexUtils.mergePdf(filePaths);
            return exportFilePath;
        } else {
            return filePaths.get(0);
        }
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R giveDemand (Integer demandId) {
        Demand demand = this.getById(demandId);
        if (demand == null) {
            return R.error("需求不存在，请联系管理员");
        }
        if (demand.getIsMeet()) {
            return R.error("请不要重复点击");
        }
        demand.setIsMeet(true);
        this.updateById(demand);
        return R.ok();
    }

    @Override
    public String exportDemandToExcel(Integer bathId, String currentUserId) throws IOException {
        // 获取当前批次中所有的需求
        Bath bath = statisticsByBathId(bathId, null);
        List<Demand> demandList = new ArrayList<>(bath.getDemandList());
        // 创建要导出的数据结构
        // 表头
        List<String> header = new ArrayList<>(Arrays.asList("物品名称", "数量", "单位", "单价"));
        // 表数据
        List<List<Object>> data = new ArrayList<>();
        for (Demand demand : demandList) {
            List<Object> obj = new ArrayList<>();
            obj.add(demand.getItemName());
            obj.add(demand.getCount());
            obj.add(demand.getUnitName());
            obj.add(demand.getPrice());
            data.add(obj);
        }
        // 创建导出文件
        String exportTemplateFilePath = filePathPropreties.getExportTemplateFilePath();
        String filePath =
                exportTemplateFilePath + "demand-excel\\" +
                        bath.getPathName() + DateTimeUtils.getCurrentDateStr() + ".xlsx";
        File file = new File(filePath);
        // 如果文件夹不存在，创建文件夹
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        // 如果文件存在，删除
        if (file.exists()) {
            file.delete();
        }
        file.createNewFile();
        // 导出
        ExcelUtil.writeBySimple(filePath, data, header);
        return filePath;
    }


}
