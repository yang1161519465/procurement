package com.xgkx.procurement.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.entity.Demand;

import java.io.IOException;
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
    R submitDemand(Demand demand);

    /**
     * 获取我的组织的需求列表
     *
     * @author 杨旭晨
     * @date 15:24 2021/4/29
     * @param currentUserId :
     * @param bathId: 批次id
     * @return java.util.List<com.xgkx.procurement.entity.Demand>
     **/
    List<Demand> getMyOrgDemandList(String currentUserId, Integer bathId);

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
     * @param bathId: 批次id
     * @param orgId: 组织机构id
     * @return com.xgkx.procurement.entity.Bath
     **/
    Bath statisticsByBathId(Integer bathId, Integer orgId);

    /**
     * 根据批次id获取列表
     *
     * @author 杨旭晨
     * @date 10:24 2021/5/9
     * @param bathId: 批次id
     * @return java.util.List<com.xgkx.procurement.entity.Demand>
     **/
    List<Demand> getListByBathId(Integer bathId);

    /**
     * 修改需求
     * 1.当前需求所在批次已经停止上报后，不允许修改
     *
     * @author 杨旭晨
     * @date 14:59 2021/5/9
     * @param demand: 要修改的需求
     * @return com.xgkx.procurement.common.entity.R
     **/
    R updateDemand(Demand demand);

    /**
     * 删除需求
     * 1.当前需求所在批次已经停止上报后，不允许删除
     * 2.需求已经给予之后，不允许删除
     *
     * @author 杨旭晨
     * @date 15:02 2021/5/9
     * @param demandId: 要删除的需求id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R deleteDemand(Integer demandId);

    /**
     * 根据批次id导出当前批次的所有需求
     *
     * @author 杨旭晨
     * @date 10:24 2021/5/21
     * @param bathId: 批次id
     * @param currentUserId: 当前登陆者用户id
     * @param data: 表格内容 包括 org_name: 组织机构名称, user_name: 申请人姓名, phone_num: 联系电话, source: 资金来源
     * @return java.lang.String
     **/
    String exprotPdf (Integer bathId, JSONObject data, String currentUserId) throws IOException;

    /**
     * 给予需求
     *
     * @author 杨旭晨
     * @date 20:41 2021/6/2
     * @param demandId: 需求id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R giveDemand (Integer demandId);

    /**
     * 导出当前批次的所有需求为excel
     *
     * @author 杨旭晨
     * @date 2021/7/2 14:32
     * @param bathId: 批次id
     * @param currentUserId: 当前登陆者用户id
     * @return java.lang.String
    **/
    String exportDemandToExcel(Integer bathId, String currentUserId) throws IOException;


}
