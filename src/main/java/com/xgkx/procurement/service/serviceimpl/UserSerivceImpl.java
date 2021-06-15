package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.MyUserDetrails;
import com.xgkx.procurement.entity.Role;
import com.xgkx.procurement.entity.User;
import com.xgkx.procurement.mapper.UserMapper;
import com.xgkx.procurement.service.RoleService;
import com.xgkx.procurement.service.UserSerivce;
import com.xgkx.procurement.util.MD5Utils;
import com.xgkx.procurement.util.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UserSerivceImpl
 * @date 2021/4/25 15:04
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class UserSerivceImpl extends ServiceImpl<UserMapper, User> implements UserSerivce, UserDetailsService {

    @Autowired
    private RoleService roleService;

    /**
     * 重写的UserDetailsService中的方法，供springSecurity使用
     *
     * @author 杨旭晨
     * @date 12:59 2021/4/26
     * @param s: 用户登录名
     * @return org.springframework.security.core.userdetails.UserDetails
     **/
    @Override
    public MyUserDetrails loadUserByUsername(String s) throws UsernameNotFoundException {
        if (StringUtils.isEmpty(s)) {
            // 用户名为空
            throw new UsernameNotFoundException("用户名为空");
        }
        User user = getByLoginName(s);
        if (user == null) {
            throw new UsernameNotFoundException("用户未找到");
        }
        // 用户角色集合
        List<GrantedAuthority> grantedAuthoritieList = new ArrayList<>();
        if (user.getRoles() == null || user.getRoles().isEmpty()) {
            // 用户没有角色
            throw new UsernameNotFoundException("用户没有分配角色");
        }
//        for (Role role : user.getRoles()) {
//            grantedAuthoritieList.add(new SimpleGrantedAuthority("ROLE_" + role.getRoleKey()));
//        }
//        return new org.springframework.security.core.userdetails.User(user.getLoginName(),
//                user.getPasswordMd5(), grantedAuthoritieList);
        return new MyUserDetrails(user);
    }

    @Override
    public User getByLoginName(String loginName) {
        User queryParams = new User();
        queryParams.setLoginName(loginName);
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("login_name", loginName);
        User user = baseMapper.selectOne(wrapper);
        if (user == null) {
            return null;
        }
        user.setRoles(roleService.getListByUserId(user.getUserId()));
        return user;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public User addUser(User user) {
        user.setPasswordMd5(MD5Utils.getMD5Str(user.getPassword()));
        this.save(user);
        if (user.getRoleIds() == null || user.getRoleIds().isEmpty()) {
            user.setRoleIds(new ArrayList<>());
        }
        roleService.setUserRole(user);
        return user;
    }

    @Override
    public User info(String currentUserId) {
        User user = baseMapper.info(currentUserId);
        List<Role> roleList = roleService.getListByUserId(user.getUserId());
        user.setRoles(roleList);
        return user;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R resetUserPassword(String userId, String newPassword) {
        User user = this.getById(userId);
        user.setPasswordMd5(MD5Utils.getMD5Str(newPassword));
        this.updateById(user);
        return R.ok();
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R changePassword(String oldPassword, String newPassword, String userId) {
        User user = this.getById(userId);
        // 判断旧密码是否符合
        if (!user.getPasswordMd5().equals(MD5Utils.getMD5Str(oldPassword))) {
            // 不符合
            return R.error("密码输入错误，请重新输入");
        }
        user.setPasswordMd5(MD5Utils.getMD5Str(newPassword));
        this.save(user);
        return R.ok();
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R changeUserInfo(User user, String userId) {
        User oldUser = this.getById(userId);
        user.setPasswordMd5(oldUser.getPasswordMd5());
        user.setLoginName(oldUser.getLoginName());
        user.setUserId(userId);
        user.setOrgId(oldUser.getOrgId());
        this.updateById(user);
        return R.ok();
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R updaetUser(User user, String userId) {
        User oldUser = this.getById(userId);
        user.setPasswordMd5(oldUser.getPasswordMd5());
        user.setLoginName(oldUser.getLoginName());
        user.setUserId(userId);
        this.updateById(user);
        return R.ok();
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R deleteUser (String userId) {
        this.removeById(userId);
        return R.ok();
    }

    @Override
    public List<User> getUserList (User user) {
        return baseMapper.getUserList(user);
    }

}
