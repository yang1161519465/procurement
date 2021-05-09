package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.entity.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 登陆  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename LoginController
 * @date 2021/4/28 11:37
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "登陆接口", tags = "登陆接口")
@Slf4j
@RestController
@RequestMapping("/login")
public class LoginController {

    @ApiOperation(value = "登陆", notes = "登陆", consumes = MediaType.APPLICATION_JSON_VALUE, produces
            = MediaType.APPLICATION_JSON_VALUE, tags = "登陆接口")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userName", value = "用户名", required = true, dataType = "String",
                    paramType = "query"),
            @ApiImplicitParam(name = "password", value = "密码", required = true, dataType = "String",
                    paramType = "query")
    })
    @PostMapping("")
    public R login(@RequestParam String userName, @RequestParam String password) {
        // 有过滤器拦截，不会进入到这个函数，这个控制器存在的意义是为了让swagger显示登陆接口
        return R.ok();
    }



}
