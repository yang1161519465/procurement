package com.xgkx.procurement.configuration;

import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.charset.Charset;

@Configuration
public class InitFastJsonConfig {

    @Bean
    FastJsonHttpMessageConverter fastJsonHttpMessageConverter () {
        FastJsonHttpMessageConverter converter= new FastJsonHttpMessageConverter();

        // 创建FastJson转换器的配置
        FastJsonConfig config = new FastJsonConfig();
        config.setDateFormat("yyyy-MM-dd HH:mm:ss"); // 设置日期格式
        config.setCharset(Charset.forName("UTF-8")); // 设置编码格式


        converter.setFastJsonConfig(config);

        return converter;
    }

}
