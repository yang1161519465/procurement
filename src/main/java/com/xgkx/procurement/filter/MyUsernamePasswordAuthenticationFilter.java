package com.xgkx.procurement.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.configuration.JwtPropreties;
import com.xgkx.procurement.constant.Constant;
import com.xgkx.procurement.entity.MyUserDetrails;
import com.xgkx.procurement.util.JwtUtils;
import com.xgkx.procurement.util.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 用户名密码认证过滤器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename MyUsernamePasswordAuthenticationFilter
 * @date 2021/4/27 9:20
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Slf4j
public class MyUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    private AuthenticationManager authenticationManager;

    private JwtPropreties jwtPropreties;


    public MyUsernamePasswordAuthenticationFilter(AuthenticationManager authenticationManager, JwtPropreties jwtPropreties) {
        this.authenticationManager = authenticationManager;
        this.jwtPropreties = jwtPropreties;
        super.setFilterProcessesUrl("/login");
    }

    /**
     * 验证成功之后，执行这个方法
     *
     * @param request:
     * @param response:
     * @param chain:
     * @param authResult:
     * @return void
     * @author 杨旭晨
     * @date 9:31 2021/4/27
     **/
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response,
                                            FilterChain chain, Authentication authResult)
            throws IOException, ServletException {
        //设置安全上下文。在当前的线程中，任何一处都可以通过SecurityContextHolder来获取当前用户认证成功的Authentication对象
        SecurityContextHolder.getContext().setAuthentication(authResult);
        log.debug("验证成功");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取用户信息
        MyUserDetrails userDetails = (MyUserDetrails) authResult.getPrincipal();
        // 生成token
        String token = JwtUtils.createToken(userDetails.getUsername(), userDetails.getUserId(), userDetails.getRoles(),
                jwtPropreties.getSignature(), jwtPropreties.getExp());
        R r = R.ok().put(Constant.TOKEN, token);
        out.write(r.toJSONString());
        out.flush();
        out.close();
    }

    /**
     * 拦截用户登陆请求，必须访问/login和post请求才可以拦截到
     *
     * @param request:
     * @param response:
     * @return org.springframework.security.core.Authentication
     * @author 杨旭晨
     * @date 9:26 2021/4/27
     **/
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        log.debug("开始验证");
        ObjectMapper mapper = new ObjectMapper();
        UsernamePasswordAuthenticationToken authRequest = null;
        // 获取用户名和密码
        String userName = request.getParameter(Constant.USERNAME);
        String password = request.getParameter(Constant.PASSWORD);
        if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
            // 用户名或密码为空
            authRequest = new UsernamePasswordAuthenticationToken("", "");
        } else {
            // 用户名和密码不为空
            authRequest = new UsernamePasswordAuthenticationToken(userName, password);
        }
        setDetails(request, authRequest);
        //提交给自定义的provider组件进行身份验证和授权
        Authentication authentication = authenticationManager.authenticate(authRequest);
        return authentication;
    }
}
