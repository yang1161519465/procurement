package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.entity.Role;

import java.util.List;

/**
 * 角色 业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename RoleService
 * @date 2021/4/25 15:02
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface RoleService extends IService<Role> {

    /**
     * 根据用户id，获取用户权限列表
     *
     * @author 杨旭晨
     * @date 12:48 2021/4/26
     * @param userId: 用户id
     * @return java.util.List<com.xgkx.procurement.entity.Role>
     **/
    List<Role> getListByUserId(String userId);

}
