package com.xgkx.procurement.configuration;

import com.xgkx.procurement.filter.MyAuthenticationFilter;
import com.xgkx.procurement.filter.MyUsernamePasswordAuthenticationFilter;
import com.xgkx.procurement.handler.MyAuthenticationAccessDeniedHandler;
import com.xgkx.procurement.handler.MyAuthenticationEntryPoint;
import com.xgkx.procurement.service.serviceimpl.UserSerivceImpl;
import com.xgkx.procurement.util.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * springSecurity配置
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename SecurityConfig
 * @date 2021/4/25 16:13
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Configuration
@EnableWebSecurity
// 开启方法级别的权限认证
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserSerivceImpl userSerivce;
    @Autowired
    private MyAuthenticationAccessDeniedHandler myAuthenticationAccessDeniedHandler;
    @Autowired
    private MyAuthenticationEntryPoint myAuthenticationEntryPoint;
    @Autowired
    private JwtPropreties jwtPropreties;

//    @Override
//    public void configure(WebSecurity web) throws Exception {
//        // 设置拦截忽略url - 会直接过滤该url - 将不会经过Spring Security过滤器链
//        web.ignoring().antMatchers("/user", "/user/*");
//        // 设置拦截忽略文件夹，可以对静态资源放行
//        web.ignoring().antMatchers("/css/**", "/js/**");
//        // 放开swagger请求
//        web.ignoring().antMatchers("/doc.html","/v2/api-docs", "/configuration/ui", "/swagger-resources",
//                "/configuration/security", "/swagger-ui.html", "/webjars/**",
//                "/swagger-resources/configuration/ui","/swagger-ui.html");
//    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        /*
            开启数据库读取密码，userService必须实现springSecurity的UserDetailsService，重写loadUserByUsername方法
         */
        auth.userDetailsService(userSerivce)
                // 修改密码加密规则
        .passwordEncoder(passwordEncoder());
    }

    /**
     * 安全拦截机制  核心
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                // CSRF是指跨站请求伪造（Cross-site request forgery）
            .csrf()
                // 关闭
                .disable()
                .cors()
            .and()
                .exceptionHandling()
                // 用户无权限，或者未登录时异常处理
                .accessDeniedHandler(myAuthenticationAccessDeniedHandler)
//            .and()
//                // 登陆认证
//                .formLogin()
//                .loginProcessingUrl("/login")
            .and()
                .addFilter(new MyUsernamePasswordAuthenticationFilter(authenticationManager(), jwtPropreties))
                .addFilter(new MyAuthenticationFilter(authenticationManager(), jwtPropreties, userSerivce))
                .exceptionHandling()
                .authenticationEntryPoint(myAuthenticationEntryPoint)
            .and()
                // 授权配置
                .authorizeRequests()
                //swagger放行
                .antMatchers("/doc.html","/v2/api-docs", "/configuration/ui", "/swagger-resources",
                        "/configuration/security", "/swagger-ui.html", "/webjars/**",
                        "/swagger-resources/configuration/ui","/swagger-ui.html").permitAll()
                // 文件请求
                .antMatchers("/assets/**", "/system/assets/**").permitAll()
                // 所有请求
                .anyRequest()
                // 都需要认证
                .authenticated();

    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // 密码加密规则修改为md5加密
        return new PasswordEncoder() {
            @Override
            public String encode(CharSequence charSequence) {
                return MD5Utils.getMD5Str((String) charSequence);
            }

            @Override
            public boolean matches(CharSequence charSequence, String s) {
                // charSequence:用户输入的密码
                // s:数据库查出来的密码
                return s.equals(MD5Utils.getMD5Str((String) charSequence));
            }
        };
    }
}
