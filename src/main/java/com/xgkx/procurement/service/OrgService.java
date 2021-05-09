package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
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

}
