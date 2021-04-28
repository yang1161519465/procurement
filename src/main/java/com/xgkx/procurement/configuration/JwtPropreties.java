package com.xgkx.procurement.configuration;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 * jwt相关配置
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename JwtPropreties
 * @date 2021/4/27 10:47
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Data
@Component
public class JwtPropreties {

    @Value("${jwt.signature}")
    private String signature;

    @Value("${jwt.exp}")
    private Integer exp;

}
