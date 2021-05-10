package com.xgkx.procurement.util;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xgkx.procurement.common.annotation.GenerateWrapperType;
import org.apache.commons.lang3.ArrayUtils;

import java.lang.reflect.Field;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * wrapper工具
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename WrapperUtil
 * @date 2021/4/25 21:08
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public class WrapperUtil {

    private static Pattern humpPattern = Pattern.compile("[A-Z]");

    public static<T> QueryWrapper<T> generateQueryWrapperFromObject(T entity) {
        Field[] declaredFields = entity.getClass().getDeclaredFields();
        declaredFields = ArrayUtils.addAll(declaredFields,
                entity.getClass().getSuperclass().getDeclaredFields());
        QueryWrapper<T> wrapper = new QueryWrapper<>();
        for (Field field : declaredFields) {
            // 关闭安全检查，提高效率，可以获得稀有变量
            field.setAccessible(true);
            try {
                if ("serialVersionUID".equals(field.getName())) {
                    // 序列化字段，忽略
                    continue;
                }
//                if (field.get(entity) == null) {
//                    // 字段为空，跳过
//                    continue;
//                }
//                if (field.get(entity).toString().equals("")) {
//                    // 字段为空，跳过
//                    continue;
//                }
                // 获取主键注解 TableId
                TableId tableId = field.getAnnotation(TableId.class);
                if (tableId != null) {
                    // 是主键  主键直接用等于
                    wrapper.eq(tableId.value(), field.get(entity));
                }
                TableField tableField = field.getAnnotation(TableField.class);
                if (tableField != null) {
                    // 存在TableField注解
                    if (tableField.exist()) {
                        // 是数据库字段映射
                        setQueryWrapper(wrapper, field, tableField, field.get(entity));
                    }
                    // 剩下的为exist = false，不是数据库中字段，不构成查询条件
                    continue;
                }

            } catch (IllegalAccessException  e) {
                e.printStackTrace();
                return null;
            }
        }
        return wrapper;
    }

    /**
     * 根据字段注释，生成相对应的wrapper类，
     * 暂时包括eq，like，in
     *
     * @author 杨旭晨
     * @date 21:54 2021/4/25
     * @param wrapper:
     * @param field: 处理的字段
     * @return void
     **/
    private static void setQueryWrapper(QueryWrapper wrapper, Field field, TableField tableField,
                                      Object value) {
        GenerateWrapperType generateWrapperType = field.getAnnotation(GenerateWrapperType.class);
        if (value == null || value.equals("s")) {
            // 字段为空，判断是否有默认值
            if (generateWrapperType != null && GenerateWrapperType.Type.DEFAULT.equals(generateWrapperType.value())) {
                // 默认值
                wrapper.eq(tableField.value(), generateWrapperType.defaultValue());
            }
            return;
        }
        if (generateWrapperType == null) {
            // 注解为空，默认为eq
            wrapper.eq(tableField.value(), value);
            return;
        }
        if (GenerateWrapperType.Type.EQ.equals(generateWrapperType.value())) {
            // eq
            wrapper.eq(tableField.value(), value);
        } else if (GenerateWrapperType.Type.IN.equals(generateWrapperType.value())) {
            // in
            wrapper.in(tableField.value(), value);
        } else if (GenerateWrapperType.Type.LIKE.equals(generateWrapperType.value())) {
            // like
            wrapper.like(tableField.value(), value);
        }
    }

    /**
     * 将驼峰命名转化为下划线命名
     *
     * @author 杨旭晨
     * @date 22:04 2021/4/25
     * @param str: 驼峰命名的变量名
     * @return java.lang.String  下划线命名的变量名
     **/
    public static String humpToLine(String str) {
        Matcher matcher = humpPattern.matcher(str);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            matcher.appendReplacement(sb, "_" + matcher.group(0).toLowerCase());
        }
        matcher.appendTail(sb);
        return sb.toString();
    }

}
