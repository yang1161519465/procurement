package com.xgkx.procurement.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xgkx.procurement.entity.Role;

import java.util.List;

/**
 * 权限mapper
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename RoleMapper
 * @date 14:59 2021/4/25
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface RoleMapper extends BaseMapper<Role> {

    /**
     * 根据用户id获取权限列表
     *
     * @author 杨旭晨
     * @date 15:55 2021/4/27
     * @param userId: 用户id
     * @return java.util.List<com.xgkx.procurement.entity.Role>
     **/
    List<Role> getListByUserId(String userId);

}
