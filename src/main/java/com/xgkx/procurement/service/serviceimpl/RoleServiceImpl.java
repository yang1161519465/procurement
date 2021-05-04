package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.entity.Role;
import com.xgkx.procurement.entity.User;
import com.xgkx.procurement.entity.UserRole;
import com.xgkx.procurement.mapper.RoleMapper;
import com.xgkx.procurement.service.RoleService;
import com.xgkx.procurement.service.UserRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename RoleServiceImpl
 * @date 2021/4/25 15:04
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    private UserRoleService userRoleService;

    @Override
    public List<Role> getListByUserId(String userId) {
        List<Role> roles = baseMapper.getListByUserId(userId);
        return roles;
    }

    @Override
    public List<UserRole> setUserRole(User user) {
        if (user.getRoleIds() == null || user.getRoleIds().isEmpty()) {
            return null;
        }
        List<Integer> roleIds = user.getRoleIds();
        List<UserRole> collect = roleIds.stream().map(item -> {
            UserRole userRole = new UserRole();
            userRole.setRoleId(item);
            userRole.setUserId(user.getUserId());
            userRole.setCreateBy(user.getCreateBy());
            return userRole;
        }).collect(Collectors.toList());
        userRoleService.saveBatch(collect);
        return collect;
    }
}
