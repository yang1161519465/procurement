package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.entity.Category;

import java.util.List;
import java.util.Map;

/**
 * 分类  业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename CategoryService
 * @date 2021/4/27 16:39
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface CategoryService extends IService<Category> {

    /**
     * 获取分类树结构
     *
     * @author 杨旭晨
     * @date 9:14 2021/4/29
     * @return java.util.List<com.xgkx.procurement.entity.Category>
     **/
    List<Category> getCategoryList();

    /**
     * 根据父级分类id，获取子分类列表
     *
     * @author 杨旭晨
     * @date 9:18 2021/4/29
     * @param cateId: 分类id
     * @return java.util.List<com.xgkx.procurement.entity.Category>
     **/
    List<Category> getListByParentId(Integer cateId);

    /**
     * 判断分类列表中的分类id，是否有子节点
     *
     * @author 杨旭晨
     * @date 16:49 2021/4/29
     * @param categoryIdList: 分类id
     * @return java.util.Map<java.lang.Integer,java.lang.Boolean>
     **/
    Map<Integer, Boolean> hasChildren(List<Integer> categoryIdList);
}
