package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.entity.Demand;
import com.xgkx.procurement.entity.Org;
import com.xgkx.procurement.mapper.DemandMapper;
import com.xgkx.procurement.service.BathService;
import com.xgkx.procurement.service.DemandService;
import com.xgkx.procurement.service.OrgService;
import com.xgkx.procurement.service.UserSerivce;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public Demand submitDemand(Demand demand) {
        save(demand);
        return demand;
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
    public Bath statisticsByBathId(Integer bathId) {
        // 获取批次信息
        Bath bath = bathService.getById(bathId);
        // 获取本批次的所有需求
        Demand queryParams = new Demand();
        queryParams.setBathId(bathId);
        List<Demand> demandList = baseMapper.getList(queryParams);
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
}
