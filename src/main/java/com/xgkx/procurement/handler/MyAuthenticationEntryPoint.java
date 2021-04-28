package com.xgkx.procurement.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename MyAuthenticationEntryPoint
 * @date 2021/4/27 9:38
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Component
public class MyAuthenticationEntryPoint implements AuthenticationEntryPoint {

    /**
     * 认证失败时，执行，返回信息
     *
     * @author 杨旭晨
     * @date 14:31 2021/4/27
     * @param httpServletRequest:
     * @param httpServletResponse:
     * @param e:
     * @return void
     **/
    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                         AuthenticationException e) throws IOException, ServletException {
        R r = R.error(HttpStatus.INTERNAL_SERVER_ERROR.value(), Msg.USERNAME_OR_PASSWORD_ERROR);
        httpServletResponse.setContentType("application/json;charset=UTF-8");
        httpServletResponse.setCharacterEncoding("UTF-8");
        httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        PrintWriter writer = httpServletResponse.getWriter();
        writer.write(r.toJSONString());
        writer.flush();
        writer.close();
    }
}
