package com.xgkx.procurement.handler;

import com.alibaba.fastjson.JSON;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import org.apache.http.entity.ContentType;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * springSecurity无权限时处理逻辑
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename CustomizeAuthenticationEntryPoint
 * @date 2021/4/26 13:45
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Component
public class MyAuthenticationAccessDeniedHandler implements AccessDeniedHandler {

    /**
     * 已经登陆用户没有权限时，执行
     *
     * @author 杨旭晨
     * @date 14:55 2021/4/27
     * @param request:
     * @param response:
     * @param accessDeniedException:
     * @return void
     **/
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException {
        String result  =
                JSON.toJSONString(R.error(HttpStatus.UNAUTHORIZED.value(), Msg.NO_AUTHORITY));
        response.setStatus(HttpStatus.UNAUTHORIZED.value());
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(result);
    }
}
