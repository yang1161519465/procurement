package com.xgkx.procurement.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 生成wrapper的类型
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename GenerateWrapperType
 * @date 2021/4/25 21:42
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
// 运行时生效
@Retention(RetentionPolicy.RUNTIME)
// 字段注解
@Target(ElementType.FIELD)
public @interface GenerateWrapperType {

    Type value() default Type.EQ;

    boolean defaultValue() default false;

    /**
     * 生成类型枚举
     */
    public enum Type {
        /**
         * 等于
         */
        EQ("eq"),
        /**
         * 模糊
         */
        LIKE("like"),
        /**
         * 在。。。中
         */
        IN("in"),
        /**
         * 默认值
         */
        DEFAULT("default");

        private final String value;

        Type(String value) {
            this.value = value;
        }

    }

}
