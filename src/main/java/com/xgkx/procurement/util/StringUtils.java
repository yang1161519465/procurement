package com.xgkx.procurement.util;

import java.util.List;

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

    /**
     * 将list转换为字符串，用拼接符号拼接
     *
     * @author 杨旭晨
     * @date 10:05 2021/5/9
     * @param list: 要转换的字符串列表
     * @param symbol: 拼接符号
     * @return java.lang.String
     **/
    public static String listToString(List<String> list, String symbol) {
        StringBuilder sb = new StringBuilder();
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                if (i < list.size() - 1) {
                    sb.append(list.get(i) + symbol);
                } else {
                    sb.append(list.get(i));
                }
            }
        }
        return sb.toString();
    }

}
