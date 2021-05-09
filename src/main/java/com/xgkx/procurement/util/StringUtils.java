package com.xgkx.procurement.util;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    /**
     * 判断字符串是否是邮箱
     *
     * @author 杨旭晨
     * @date 18:35 2021/5/9
     * @param s: 要判断的字符换
     * @return boolean  true: 是一个邮箱,  false: 不是一个邮箱
     **/
    public static boolean isEmail(String s) {
        if (isEmpty(s)) {
            return false;
        }
        String regEx1 = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        Pattern p = Pattern.compile(regEx1);
        Matcher m = p.matcher(s);
        if(m.matches()){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 判断字符串是否是电话号码格式
     *
     * @author 杨旭晨
     * @date 18:37 2021/5/9
     * @param s: 要判断的字符串
     * @return boolean  true: 是电话号码,  false: 不是电话号码
     **/
    public static boolean isPhoneNum(String s) {
        if (isEmpty(s)) {
            return false;
        }
        String regEx1 = "^1[3|4|5|7|8][0-9]\\\\d{4,8}$";
        Pattern p = Pattern.compile(regEx1);
        Matcher m = p.matcher(s);
        if(m.matches()){
            return true;
        }else{
            return false;
        }
    }
}
