package com.xgkx.procurement.util;

import com.xgkx.procurement.constant.Constant;
import io.jsonwebtoken.*;
import org.apache.tomcat.util.bcel.Const;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.*;

/**
 * Jwt相关工具类
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename JwtUtils
 * @date 2021/4/26 17:44
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public class JwtUtils {



    /**
     * 生成jwt  token   jjwt使用参考  https://www.jianshu.com/p/1ebfc1d78928
     *
     * @author 杨旭晨
     * @date 22:11 2021/4/26
     * @param loginName: 用户登录名
     * @param userId: 用户id
     * @param roles: 用户角色列表   key列表
     * @param signature: 签名
     * @param exp: 过期时间  单位：s
     * @return java.lang.String
     **/
    public static String createToken(String loginName, String userId, Collection<? extends GrantedAuthority> roles, String signature
            , Integer exp) {
        // 设置claims，claims是jwt的负载部分
        Map<String, Object> claims = new HashMap<>();
        claims.put(Constant.USERNAME, loginName);
        claims.put(Constant.USERID, userId);
        claims.put(Constant.ROLE, roles);
        claims.put(Constant.EXP, exp);
        String token = Jwts
                // 开始构建
                .builder()
                // 设置负载  载荷部分存在两个属性：payload和claims。两个属性均可作为载荷，jjwt中二者只能设置其一，如果同时设置，在终端方法compact() 中将抛出异常
                .setClaims(claims)
                // 设置过期时间，
                .setExpiration(new Date(System.currentTimeMillis() + exp * 1000))
                // 设置签名
                .signWith(SignatureAlgorithm.HS512, signature)
                // 生成
                .compact();
        return token;
    }

    /**
     * 解密token
     *
     * @author 杨旭晨
     * @date 22:47 2021/4/26
     * @param token: 要解密的token
     * @param signature: 签名
     * @return io.jsonwebtoken.Claims
     **/
    public static Claims decodeToken(String token, String signature) throws Exception {
        Claims claims = null;
        try {
            // 获取jwt的负载
            claims = Jwts.parser()
                    // 解密签名
                    .setSigningKey(signature)
                    // 设置解密token
                    .parseClaimsJws(token)
                    // 获取负载
                    .getBody();
        } catch (Exception e) {
            // 异常
            /*
            JwtException 总异常
            ClaimJwtException 获取Claim异常
            ExpiredJwtException token过期异常
            IncorrectClaimException token无效
            MalformedJwtException 密钥验证不一致
            MissingClaimException JWT无效
            RequiredTypeException 必要类型异常
            SignatureException 签名异常
            UnsupportedJwtException 不支持JWT异常
             */
            throw e;
        }
        return claims;
    }

    /**
     * 获取token中的用户名
     *
     * @author 杨旭晨
     * @date 22:48 2021/4/26
     * @param token:
     * @param signature: 签名
     * @return java.lang.String
     **/
    public static String getUserName(String token, String signature) throws Exception {
        Claims claims = decodeToken(token, signature);
        if (claims == null) {
            return null;
        }
        return claims.get(Constant.USERNAME, String.class);
    }

    /**
     * 获取token中的用户id
     *
     * @author 杨旭晨
     * @date 8:59 2021/4/27
     * @param token:
     * @param signature: 签名
     * @return java.lang.String
     **/
    public static String getUserId(String token, String signature) throws Exception {
        Claims claims = decodeToken(token, signature);
        if (claims == null) {
            return null;
        }
        return claims.get(Constant.USERID, String.class);
    }

    /**
     * 获取token中的角色列表
     *
     * @author 杨旭晨
     * @date 9:00 2021/4/27
     * @param token:
     * @param signature: 签名
     * @return java.util.List<java.lang.String>
     **/
    public static List<String> getRoles(String token, String signature) throws Exception {
        Claims claims = decodeToken(token, signature);
        if (claims == null) {
            return new ArrayList<>();
        }
        List<String> roles = claims.get(Constant.ROLE, List.class);
        return roles;
    }

    /**
     * 验证token是否有效
     *
     * @author 杨旭晨
     * @date 11:09 2021/4/27
     * @param token:
     * @param signature: 签名
     * @return boolean
     **/
    public static boolean verifyToken(String token, String signature) {
        try {
            decodeToken(token, signature);
        } catch (Exception e) {
            return false;
        } finally {
            return true;
        }
    }

    /**
     * 测试jwt工具类
     *
     * @author 杨旭晨
     * @date 9:03 2021/4/27
     * @param args:
     * @return void
     **/
    public static void main(String[] args) throws Exception {
        String token = createToken("yxc", "1111111",
                Arrays.asList(new SimpleGrantedAuthority("admin"), new SimpleGrantedAuthority("user")),
                "yangxuchen", 60*60);
        Thread.sleep(1000);
        String userName = getUserName(token, "yangxuchen");
        String userId = getUserId(token, "yangxuchen");
        List<String> roles = getRoles(token, "yangxuchen");
        System.out.println(token);
        System.out.println(userName);
        System.out.println(userId);
        System.out.println(roles);
    }

}
