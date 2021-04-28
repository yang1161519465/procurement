package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.entity.Role;
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

}
