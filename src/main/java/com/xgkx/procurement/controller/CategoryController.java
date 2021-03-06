package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Category;
import com.xgkx.procurement.service.serviceimpl.CategoryServiceImpl;
import com.xgkx.procurement.util.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 分类  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename CategoryController
 * @date 2021/4/27 16:46
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "分类管理接口", tags = "分类管理接口")
@Slf4j
@RestController
@RequestMapping("/category")
public class CategoryController extends BaseController<Category, Integer, CategoryServiceImpl> {

    @ApiOperation(value = "获取分类树", notes = "获取分类树", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @GetMapping("/getCategoryList")
    public R getCategoryList() {
        List<Category> resultList = service.getCategoryList();
        return R.ok().put("data", resultList);
    }

    @ApiOperation(value = "根据父分类获取子分类列表", notes = "根据父分类获取子分类列表", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "cateId", value = "父级分类id", required = true, dataType = "String",
                    paramType = "query")
    })
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @GetMapping("/getListByParentId")
    public R getListByParentId(@RequestParam Integer cateId) {
        if (cateId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<Category> resultList = service.getListByParentId(cateId);
        return R.ok().put("data", resultList);
    }

    @ApiOperation(value = "添加一个分类", notes = "添加一个分类", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/addCategory")
    public R addCategory(@RequestBody Category category) {
        if (category == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> result = checkCategory(category);
        if (!result.isEmpty()) {
            return R.error(StringUtils.listToString(result, "\n"));
        }
        category.setCreateBy(getCurrentUserLoginName());
        return service.addCategory(category);
    }

    @ApiOperation(value = "修改分类信息", notes = "修改分类信息", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/updateCategory")
    public R updateCategory(@RequestBody Category category) {
        if (category == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        if (category.getCateId() == null) {
            return R.error("分类id不能为空");
        }
        List<String> result = checkCategory(category);
        if (!result.isEmpty()) {
            return R.error(StringUtils.listToString(result, "\n"));
        }
        category.setUpdateBy(getCurrentUserLoginName());
        return service.updateCategory(category);
    }

    @ApiOperation(value = "删除分类信息", notes = "删除分类信息，有子分类，不删除，如果分类下面有物品，不删除",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/deleteCategoryNotDeleteItem")
    public R deleteCategoryNotDeleteItem(@RequestParam Integer categoryId) {
        if (categoryId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteCategory(categoryId, false, false);
    }

    @ApiOperation(value = "删除分类信息", notes = "删除分类信息，有子分类，不删除，如果分类下面有物品，删除",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/deleteCategoryDeleteItem")
    public R deleteCategoryDeleteItem(@RequestParam Integer categoryId) {
        if (categoryId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteCategory(categoryId, false, true);
    }

    @ApiOperation(value = "删除分类信息", notes = "删除分类信息，有子分类，删除，如果分类下面有物品，删除",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/deleteCategoryDeleteItemDeleteChildren")
    public R deleteCategoryDeleteItemDeleteChildren(@RequestParam Integer categoryId) {
        if (categoryId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteCategory(categoryId, true, true);
    }

    /**
     * 检查分类字段
     *
     * @author 杨旭晨
     * @date 11:02 2021/5/9
     * @param category: 要检查的实体类
     * @return java.util.List<java.lang.String>
     **/
    private List<String> checkCategory(Category category) {
        List<String> result = new ArrayList<>();
        if (category == null) {
            result.add("参数为空");
            return result;
        }
        if (StringUtils.isEmpty(category.getCateName())) {
            result.add("分类名称不能为空");
        }
        if (category.getParentId() == null) {
            result.add("分类父id为空");
        }
        return result;
    }

}
