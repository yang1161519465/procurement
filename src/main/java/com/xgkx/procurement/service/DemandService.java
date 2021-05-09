package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.entity.Demand;

import java.util.List;

/**
 * 需求  业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename DemandService
 * @date 2021/4/27 16:38
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface DemandService extends IService<Demand> {

    /**
     * 提交一个需求，并返回这个需求
     *
     * @author 杨旭晨
     * @date 9:29 2021/4/29
     * @param demand:
     * @return com.xgkx.procurement.entity.Demand
     **/
    Demand submitDemand(Demand demand);

    /**
     * 获取我的组织的需求列表
     *
     * @author 杨旭晨
     * @date 15:24 2021/4/29
     * @param currentUserId :
     * @param pageSize
     * @param pageNum
     * @return java.util.List<com.xgkx.procurement.entity.Demand>
     **/
    List<Demand> getMyOrgDemandList(String currentUserId);

    /**
     * 根据条件查询，拼接名称
     *
     * @author 杨旭晨
     * @date 10:34 2021/5/3
     * @param demand:
     * @return java.util.List
     **/
    List getList(Demand demand);

    /**
     * 根据批次id，获取本批次的统计信息
     *
     * @author 杨旭晨
     * @date 10:43 2021/5/3
     * @param bathId:
     * @return com.xgkx.procurement.entity.Bath
     **/
    Bath statisticsByBathId(Integer bathId);

    /**
     * 根据批次id获取列表
     *
     * @author 杨旭晨
     * @date 10:24 2021/5/9
     * @param bathId: 批次id
     * @return java.util.List<com.xgkx.procurement.entity.Demand>
     **/
    List<Demand> getListByBathId(Integer bathId);
}
