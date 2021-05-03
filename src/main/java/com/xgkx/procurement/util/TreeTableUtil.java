package com.xgkx.procurement.util;

import org.apache.commons.lang3.reflect.FieldUtils;
import org.springframework.beans.BeanUtils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Copyright (C), 2020-2021, XXX有限公司
 * FileName: TreeTableUtil
 * Author:   wuziqian
 * Date:     2021/1/26 21:07
 * Description: 树形工具类
 * History:
 * <author>          <time>          <version>          <desc>
 * 作者姓名           修改时间           版本号              描述
 */
public class TreeTableUtil {
    /**
     * 把列表转换为树结构
     *
     * @param originalList      原始list数据
     * @param idFieldName       作为唯一标示的字段名称
     * @param pidFieldName      父节点标识字段名
     * @param childrenFieldName 子节点（列表）标识字段名
     * @return 树结构列表
     */
    public static <T> List<T> list2TreeList(List<T> originalList, String idFieldName, String pidFieldName,
                                            String childrenFieldName) {
        if (originalList == null || originalList.isEmpty()) {
            return new ArrayList<>();
        }

        // 获取根节点，即找出父节点为空的对象
        List<T> rootNodeList = new ArrayList<>();
        List idList = originalList.stream().map(item -> {
            try {
                Method method = item.getClass().getMethod("get" + idFieldName);
                return method.invoke(item);
            } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
                e.printStackTrace();
                return 0;
            }
        }).collect(Collectors.toList());
        for (T t : originalList) {
            Object parentId = null;
            try {
                Method method = BeanUtils.findMethod(t.getClass(), "get" + pidFieldName);
                parentId = method.invoke(t);
            } catch (IllegalAccessException | InvocationTargetException e) {
                e.printStackTrace();
            }
            if (!idList.contains(parentId)) {
                rootNodeList.add(t);
            }
        }

        // 将根节点从原始list移除，减少下次处理数据
        originalList.removeAll(rootNodeList);

        // 递归封装树
        try {
            packTree(rootNodeList, originalList, idFieldName, pidFieldName, childrenFieldName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return rootNodeList;
    }

    /**
     * 封装树（向下递归）
     *
     * @param parentNodeList    要封装为树的父节点对象集合
     * @param originalList      原始list数据
     * @param keyName           作为唯一标示的字段名称
     * @param pidFieldName      父节点标识字段名
     * @param childrenFieldName 子节点（列表）标识字段名
     */
    private static <T> void packTree(List<T> parentNodeList, List<T> originalList, String keyName,
                                     String pidFieldName, String childrenFieldName) throws Exception {
        for (T parentNode : parentNodeList) {
            // 找到当前父节点的子节点列表
            List<T> children = packChildren(parentNode, originalList, keyName, pidFieldName, childrenFieldName);
            if (children.isEmpty()) {
                continue;
            }

            // 将当前父节点的子节点从原始list移除，减少下次处理数据
            originalList.removeAll(children);

            // 开始下次递归
            packTree(children, originalList, keyName, pidFieldName, childrenFieldName);
        }
    }

    /**
     * 封装子对象
     *
     * @param parentNode        父节点对象
     * @param originalList      原始list数据
     * @param keyName           作为唯一标示的字段名称
     * @param pidFieldName      父节点标识字段名
     * @param childrenFieldName 子节点（列表）标识字段名
     */
    private static <T> List<T> packChildren(T parentNode, List<T> originalList, String keyName, String pidFieldName,
                                            String childrenFieldName) throws Exception {
        // 找到当前父节点下的子节点列表
        List<T> childNodeList = new ArrayList<>();
        // 获取实体类当中的get方法
        Method method = BeanUtils.findMethod(parentNode.getClass(), "get" + keyName);
        Object parentId = method.invoke(parentNode);
        for (T t : originalList) {
            // 获取实体类当中的get方法
            Method method1 = BeanUtils.findMethod(t.getClass(), "get" + pidFieldName);
            Object childNodeParentId = method1.invoke(t);
            if (parentId.equals(childNodeParentId)) {
                childNodeList.add(t);
            }
        }

        // 将当前父节点下的子节点列表写入到当前父节点下（给子节点列表字段赋值）
        if (!childNodeList.isEmpty()) {
            // parentNode  实体类
            // childrenFieldName  要赋值的字段名
            // childNodeList  值
            FieldUtils.writeDeclaredField(parentNode, childrenFieldName.toLowerCase(), childNodeList, true);
        }

        return childNodeList;
    }
}
