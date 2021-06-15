package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.User;

import java.util.List;

/**
 * 用户 业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UserSerivce
 * @date 2021/4/25 15:02
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface UserSerivce extends IService<User> {

    /**
     * 根据登录名查找用户
     *
     * @author 杨旭晨
     * @date 12:42 2021/4/26
     * @param loginName: 登录名
     * @return com.xgkx.procurement.entity.User
     **/
    User getByLoginName(String loginName);

    /**
     * 添加用户
     *
     * @author 杨旭晨
     * @date 13:19 2021/4/26
     * @param user: 要添加的用户
     * @return com.xgkx.procurement.entity.User
     **/
    User addUser(User user);

    /**
     * 获取当前用户信息
     *
     * @author 杨旭晨
     * @date 16:49 2021/5/4
     * @param currentUserId: 用户id
     * @return com.xgkx.procurement.entity.User
     **/
    User info(String currentUserId);

    /**
     * 管理员重新设置用户密码
     *
     * @author 杨旭晨
     * @date 17:44 2021/5/9
     * @param userId: 要设置的用户id
     * @param newPassword: 新密码
     * @return com.xgkx.procurement.common.entity.R
     **/
    R resetUserPassword(String userId, String newPassword);

    /**
     * 用户修改密码
     * 1.校验旧密码是否正确
     * 2.重置
     *
     * @author 杨旭晨
     * @date 17:45 2021/5/9
     * @param oldPassword: 旧密码
     * @param newPassword: 新密码
     * @param userId: 用户id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R changePassword(String oldPassword, String newPassword, String userId);

    /**
     * 用户修改个人信息
     * 1.查询用户个人信息
     * 2.不允许修改组织机构
     * 3.此方法不修改密码
     * 4.登录名不可以修改
     *
     * @author 杨旭晨
     * @date 18:22 2021/5/9
     * @param user:
     * @param userId:
     * @return com.xgkx.procurement.common.entity.R
     **/
    R changeUserInfo(User user, String userId);

    /**
     * 修改用户信息
     * 1.此方法不修改密码
     * 2.登录名不可以修改
     *
     * @author 杨旭晨
     * @date 18:40 2021/5/9
     * @param user: 要修改的用户信息
     * @param userId: 用户id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R updaetUser(User user, String userId);

    /**
     * 删除用户
     *
     * @author 杨旭晨
     * @date 15:41 2021/6/3
     * @param userId: 用户id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R deleteUser (String userId);

    /**
     * 根据条件获取用户列表
     *
     * @author 杨旭晨
     * @date 10:30 2021/6/15
     * @param user: 查询条件
     * @return java.util.List<com.xgkx.procurement.entity.User>
     **/
    List<User> getUserList (User user);
}
