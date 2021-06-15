package com.xgkx.procurement.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xgkx.procurement.entity.User;

import java.util.List;

/**
 * 用户mapper
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UserMapper
 * @date 14:59 2021/4/25
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface UserMapper extends BaseMapper<User> {

    /**
     * 查询用户信息，不包括密码
     *
     * @author 杨旭晨
     * @date 18:33 2021/5/21
     * @param currentUserId: 用户id
     * @return com.xgkx.procurement.entity.User
     **/
    User info (String currentUserId);

    /**
     * 查询用户列表
     *
     * @author 杨旭晨
     * @date 10:30 2021/6/15
     * @param user:
     * @return java.util.List<com.xgkx.procurement.entity.User>
     **/
    List<User> getUserList (User user);
}
