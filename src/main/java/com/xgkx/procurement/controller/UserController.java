package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.User;
import com.xgkx.procurement.service.UserSerivce;
import com.xgkx.procurement.util.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

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
        List<String> checkResult = checkUser(user);
        if (StringUtils.isEmpty(user.getPassword())) {
            checkResult.add("密码不能为空");
        }
        if (user.getRoleIds() == null || user.getRoleIds().isEmpty()) {
            checkResult.add("用户角色不能为空");
        }
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        user.setCreateBy(getCurrentUserLoginName());
        return R.ok().put("data", service.addUser(user));
    }

    @ApiOperation(value = "获取当前登陆用户信息", notes = "获取当前登陆用户信息", consumes = MediaType.APPLICATION_JSON_VALUE, produces
            = MediaType.APPLICATION_JSON_VALUE, tags = "用户管理接口")
    @PostMapping("info")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    public R info() {
        String currentUserId = getCurrentUserId();
        return R.ok().put("data", service.info(currentUserId));
    }

    @ApiOperation(value = "修改用户密码", notes = "修改用户密码", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "用户管理接口")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userId", value = "用户id", required = true, dataType = "String",
                    paramType = "query"),
            @ApiImplicitParam(name = "newPassword", value = "新密码", required = true, dataType = "String",
                    paramType = "query")
    })
    @PostMapping("resetUserPassword")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    public R resetUserPassword(@RequestParam String userId, @RequestParam String newPassword) {
        if (StringUtils.isEmpty(userId) || StringUtils.isEmpty(newPassword)) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.resetUserPassword(userId, newPassword);
    }

    @ApiOperation(value = "修改密码", notes = "修改密码", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "用户管理接口")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "oldPassword", value = "旧密码", required = true, dataType = "String",
                    paramType = "query"),
            @ApiImplicitParam(name = "newPassword", value = "新密码", required = true, dataType = "String",
                    paramType = "query")
    })
    @PostMapping("changePassword")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    public R changePassword(@RequestParam String oldPassword, @RequestParam String newPassword) {
        if (StringUtils.isEmpty(oldPassword) || StringUtils.isEmpty(newPassword)) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.changePassword(oldPassword, newPassword);
    }

    @ApiOperation(value = "修改个人信息", notes = "修改个人信息，组织机构不可以修改，不修改密码，登录名不可以修改", consumes =
            MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "用户管理接口")
    @PostMapping("changeUserInfo")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    public R changeUserInfo(@RequestBody User user) {
        if (user == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkUser(user);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        return service.changeUserInfo(user, getCurrentUserId());
    }

    @ApiOperation(value = "修改用户信息", notes = "修改用户信息，不修改密码，登录名不可以修改", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "用户管理接口")
    @PostMapping("updaetUser")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    public R updaetUser(@RequestBody User user) {
        if (user == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkUser(user);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        return service.updaetUser(user);
    }

    /**
     * 检查用户信息
     *
     * @author 杨旭晨
     * @date 18:20 2021/5/9
     * @param user:
     * @return java.util.List<java.lang.String>
     **/
    private List<String> checkUser(User user) {
        List<String> result = new ArrayList<>();
        if (user == null) {
            result.add("参数不能为空");
            return result;
        }
        if (StringUtils.isEmpty(user.getUserName())) {
            result.add("用户名不能为空");
        }
        if (StringUtils.isEmpty(user.getLoginName())) {
            result.add("登陆名不能为空");
        }
        if (StringUtils.isNotEmpty(user.getEmail()) && !StringUtils.isEmail(user.getEmail())) {
            result.add("邮箱格式错误");
        }
        if (StringUtils.isNotEmpty(user.getPhoneNum()) && !StringUtils.isPhoneNum(user.getPhoneNum())) {
            result.add("电话号码格式错误");
        }
        return result;
    }


}
