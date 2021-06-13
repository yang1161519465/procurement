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
import com.xgkx.procurement.util.ItexUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
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
        save(demand);
        return R.ok().put("data", demand);
    }

    @Override
    public List<Demand> getMyOrgDemandList(String currentUserId) {
//        User user = userSerivce.getById(currentUserId);
        return baseMapper.getMyOrgDemandList(currentUserId);
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
            String key = new StringBuilder().append(demand.getItemId()).append(demand.getUnitId()).toString();
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
}
