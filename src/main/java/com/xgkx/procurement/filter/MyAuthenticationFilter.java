package com.xgkx.procurement.filter;

import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.configuration.JwtPropreties;
import com.xgkx.procurement.constant.Constant;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.MyUserDetrails;
import com.xgkx.procurement.service.serviceimpl.UserSerivceImpl;
import com.xgkx.procurement.util.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

/**
 * 验证所有请求，是否携带token
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename MyAuthenticationFilter
 * @date 2021/4/27 11:00
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Slf4j
public class MyAuthenticationFilter extends BasicAuthenticationFilter {

    private JwtPropreties jwtPropreties;
    private UserSerivceImpl userSerivce;

    private List<String> witeList = Arrays.asList("/doc.html","/v2/api-docs", "/configuration/ui", "/swagger-resources",
            "/configuration/security", "/swagger-ui.html", "/webjars/",
            "/swagger-resources/configuration/ui","/swagger-ui.html");

    public MyAuthenticationFilter(AuthenticationManager authenticationManager, JwtPropreties jwtPropreties,
                                  UserSerivceImpl userSerivce) {
        super(authenticationManager);
        this.jwtPropreties = jwtPropreties;
        this.userSerivce = userSerivce;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        response.setContentType("application/json;charset=UTF-8");
        String token = request.getHeader(Constant.TOKEN);
        String requestURI = request.getRequestURI();
        log.info("访问接口" + requestURI);
        if (isInWiteList(requestURI)) {
            // 白名单，放过
            chain.doFilter(request, response);
            return;
        }

        if (token == null) {
            // token为空
            returnMsg(response, R.error(HttpStatus.UNAUTHORIZED.value(), Msg.UN_AUTHENTICATE));
            return;
        }
        // 验证token是否合法，后期可能会存到redis当中，验证是否存在
        if (!JwtUtils.verifyToken(token, jwtPropreties.getSignature())) {
            // token不合法或者token过期
            returnMsg(response, R.error(HttpStatus.UNAUTHORIZED.value(), Msg.UNKNOW_TOKEN));
            return;
        }
        String userName = null;
        try {
            userName = JwtUtils.getUserName(token, jwtPropreties.getSignature());
        } catch (Exception e) {
            // 用户名为空
            returnMsg(response, R.error(HttpStatus.UNAUTHORIZED.value(), Msg.UNKNOW_TOKEN));
            return;
        }
        MyUserDetrails userDetails = userSerivce.loadUserByUsername(userName);
        //生成生物认证
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(request, response);
    }

    /**
     * 返回数据
     *
     * @author 杨旭晨
     * @date 17:01 2021/4/27
     * @param response: 响应
     * @param r: 返回对象
     * @return void
     **/
    private void returnMsg(HttpServletResponse response, R r) throws IOException {
        PrintWriter writer = response.getWriter();
        writer.write(r.toJSONString());
        writer.flush();
        writer.close();
    }

    private boolean isInWiteList(String url) {
        for (String s : witeList) {
            if (url.startsWith(s)) {
                return true;
            }
        }
        return false;
    }
}
