package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Org;

import java.util.List;

/**
 * 组织架构  业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename OrgService
 * @date 2021/4/27 16:36
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface OrgService extends IService<Org> {

    /**
     * 根据组织结构id列表，获取组织结构列表
     *
     * @author 杨旭晨
     * @date 8:14 2021/5/6
     * @param orgIds:
     * @return java.util.List<com.xgkx.procurement.entity.Org>
     **/
    List<Org> getListByOrgIds(List<Integer> orgIds);

    /**
     * 添加组织机构
     *
     * @author 杨旭晨
     * @date 15:36 2021/5/9
     * @param org: 要添加的组织机构
     * @return com.xgkx.procurement.common.entity.R
     **/
    R addOrg(Org org);

    /**
     * 修改组织机构
     *
     * @author 杨旭晨
     * @date 15:37 2021/5/9
     * @param org: 要修改的组织机构
     * @return com.xgkx.procurement.common.entity.R
     **/
    R updateOrg(Org org);

    /**
     * 删除组织机构
     * 1.如果组织机构下没有成员，没有提交任何需求，真删除
     * 2.如果组织机构下有成员，不可删除
     * 3.如果组织机构下没有成员，但提交过需求，逻辑删除
     *
     * @author 杨旭晨
     * @date 15:39 2021/5/9
     * @param orgId: 要删除的组织机构id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R deleteOrg(Integer orgId);
}
