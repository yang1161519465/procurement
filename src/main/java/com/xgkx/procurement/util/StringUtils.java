package com.xgkx.procurement.util;

/**
 * String类的工具类
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename StringUtils
 * @date 2021/4/26 12:38
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public class StringUtils {

    /**
     * 判断字符串是不是空
     *
     * @author 杨旭晨
     * @date 12:39 2021/4/26
     * @param s: 要判断的字符串
     * @return boolean true：空   false：非空
     **/

    public static boolean isEmpty(String s) {
        return s == null || s.isEmpty();
    }

    /**
     * 判断字符串是不是非空
     *
     * @author 杨旭晨
     * @date 12:40 2021/4/26
     * @param s: 要判断的字符串
     * @return boolean true：非空  false：空
     **/
    public static boolean isNotEmpty(String s) {
        return !isEmpty(s);
    }

}
