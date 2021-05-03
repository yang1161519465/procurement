package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.User;
import com.xgkx.procurement.exception.BussinessException;
import com.xgkx.procurement.service.UserSerivce;
import io.swagger.annotations.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 用户 controller
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UserController
 * @date 2021/4/25 15:21
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "用户管理接口", tags = "用户管理接口")
@Slf4j
@RestController
@RequestMapping("/user")
public class UserController extends BaseController<User, String, UserSerivce> {


    @ApiOperation(value = "添加用户", notes = "添加用户", consumes = MediaType.APPLICATION_JSON_VALUE, produces
            = MediaType.APPLICATION_JSON_VALUE, tags = "用户管理接口")
    @ApiImplicitParam(name = "user", value = "用户信息", required = true, dataType = "User",
            paramType = "body")
    @PostMapping("add")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    public R add(@RequestBody User user) {
        if (user == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return R.ok().put("data", service.addUser(user));
    }

    @ApiOperation(value = "获取当前登陆用户信息", notes = "获取当前登陆用户信息", consumes = MediaType.APPLICATION_JSON_VALUE, produces
            = MediaType.APPLICATION_JSON_VALUE, tags = "用户管理接口")
    @PostMapping("info")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    public R info() {
        String currentUserId = getCurrentUserId();
        return R.ok().put("data", service.getById(currentUserId));
    }

}
