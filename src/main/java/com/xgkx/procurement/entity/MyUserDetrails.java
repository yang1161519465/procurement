package com.xgkx.procurement.entity;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.*;

/**
 * 用户详情，用于springsecurity验证
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename MyUserDetrails
 * @date 2021/4/27 10:09
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Data
public class MyUserDetrails implements UserDetails {

    private String userId;
    private String loginName;
    private String password;
    private Collection<? extends GrantedAuthority> roles;

    public MyUserDetrails() {
    }

    public MyUserDetrails(User user) {
        this.userId = user.getUserId();
        this.loginName = user.getLoginName();
        this.password = user.getPasswordMd5();
        List<Role> userRoles = user.getRoles();
        ArrayList<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        for (Role userRole : userRoles) {
            grantedAuthorities.add(new SimpleGrantedAuthority(userRole.getRoleKey()));
        }
        this.roles = grantedAuthorities;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return loginName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
