package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Category;
import com.xgkx.procurement.service.serviceimpl.CategoryServiceImpl;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

//    @ApiOperation(value = "添加一个分类", notes = "添加一个分类", consumes = MediaType.APPLICATION_JSON_VALUE,
//            produces = MediaType.APPLICATION_JSON_VALUE, tags = "分类管理接口")
//    @ApiImplicitParams({
//            @ApiImplicitParam(name = "cateId", value = "父级分类id", required = true, dataType = "String",
//                    paramType = "query")
//    })
//    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
//    @GetMapping("/getListByParentId")
//    public R getListByParentId(@RequestParam Integer cateId) {
//        if (cateId == null) {
//            return R.error(Msg.PARAMETER_NULL_MSG);
//        }
//        List<Category> resultList = service.getListByParentId(cateId);
//        return R.ok().put("data", resultList);
//    }

}
