package com.xgkx.procurement.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xgkx.procurement.entity.Demand;

import java.util.List;

public interface DemandMapper extends BaseMapper<Demand> {

    /**
     * 根据组织，获取需求列表  联查 物品名称等
     *
     * @author 杨旭晨
     * @date 10:17 2021/5/3
     * @param userId: 用户id
     * @return java.util.List<com.xgkx.procurement.entity.Demand>
     **/
    List<Demand> getMyOrgDemandList(String userId);

    /**
     * 根据条件查询，拼接名称
     *
     * @author 杨旭晨
     * @date 10:34 2021/5/3
     * @param demand:
     * @return java.util.List
     **/
    List getList(Demand demand);
}
