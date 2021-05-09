package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
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

    /**
     * 添加一个分类
     * 1.判断当前分类名称是否在当前父节点下已经存在，同一个父节点下面不能有同名的分类
     *
     * @author 杨旭晨
     * @date 11:08 2021/5/9
     * @param category: 要添加的分类
     * @return com.xgkx.procurement.common.entity.R
     **/
    R addCategory(Category category);

    /**
     * 修改分类信息
     * 1.判断当前分类名称是否在当前父节点下已经存在，同一个父节点下面不能有同名的分类
     *
     * @author 杨旭晨
     * @date 11:12 2021/5/9
     * @param category: 要修改的分类
     * @return com.xgkx.procurement.common.entity.R
     **/
    R updateCategory(Category category);

    /**
     * 删除分类信息
     * 1.判断是否有子分类，根据是否删除子分类进行删除
     * 2.判断是否有物品，根据是否删除物品，进行删除
     *
     * @author 杨旭晨
     * @date 11:17 2021/5/9
     * @param categoryId:
     * @param isDeleteChildren:
     * @param isDeleteItem:
     * @return com.xgkx.procurement.common.entity.R
     **/
    R deleteCategory(Integer categoryId, boolean isDeleteChildren, boolean isDeleteItem);
}
