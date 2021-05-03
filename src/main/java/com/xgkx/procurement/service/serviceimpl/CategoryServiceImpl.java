package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.entity.Category;
import com.xgkx.procurement.mapper.CategoryMapper;
import com.xgkx.procurement.service.CategoryService;
import com.xgkx.procurement.util.TreeTableUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename CategoryServiceImpl
 * @date 2021/4/27 16:39
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

    @Override
    public List<Category> getCategoryList() {
        List<Category> categoryList = list();
        List<Category> treeList = TreeTableUtil.list2TreeList(categoryList, "CateId", "ParentId", "Children");
        return treeList;
    }

    @Override
    public List<Category> getListByParentId(Integer cateId) {
        QueryWrapper<Category> wrapper = new QueryWrapper<>();
        wrapper.eq("parent_id", cateId);
        List<Category> categoryList = baseMapper.selectList(wrapper);
        List<Integer> categoryIdList =
                categoryList.stream().map(Category::getCateId).collect(Collectors.toList());
        Map<Integer, Boolean> hasChildrenMap = hasChildren(categoryIdList);
        for (Category category : categoryList) {
            if (hasChildrenMap.containsKey(category.getCateId())) {
                category.setHasChildren(true);
            } else {
                category.setHasChildren(false);
            }
        }
        return categoryList;
    }

    @Override
    public Map<Integer, Boolean> hasChildren(List<Integer> categoryIdList) {
        QueryWrapper<Category> wrapper = new QueryWrapper<>();
        wrapper.in("parent_id", categoryIdList);
        List<Category> categoryList = baseMapper.selectList(wrapper);
        Map<Integer, Boolean> resultMap = new HashMap<>();
        for (Category category : categoryList) {
            resultMap.put(category.getCateId(), true);
        }
        return resultMap;
    }
}
