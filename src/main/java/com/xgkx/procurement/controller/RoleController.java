package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.entity.Role;
import com.xgkx.procurement.service.serviceimpl.RoleServiceImpl;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 角色  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename RoleController
 * @date 2021/4/26 13:54
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "角色管理接口", tags = "角色管理接口")
@Slf4j
@RestController
@RequestMapping("/role")
public class RoleController extends BaseController<Role, Integer, RoleServiceImpl> {


}
