package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Item;
import com.xgkx.procurement.service.serviceimpl.ItemServiceImpl;
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
 * 物品  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename ItemController
 * @date 2021/4/27 16:44
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "物品管理接口", tags = "物品管理接口")
@Slf4j
@RestController
@RequestMapping("/item")
public class ItemController extends BaseController<Item, Integer, ItemServiceImpl> {


    @ApiOperation(value = "根据分类获取物品列表", notes = "根据分类获取物品列表", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "物品管理接口")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "cateId", value = "分类id", required = true, dataType = "Integer",
                    paramType = "query")
    })
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @GetMapping("/getListByCateId")
    public R getListByCateId(@RequestParam Integer cateId) {
        if (cateId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<Item> resultList = service.getListByCateId(cateId);
        return R.ok().put("data", resultList);
    }

    @ApiOperation(value = "根据查询字符串查询物品列表", notes = "根据查询字符串查询物品列表", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "物品管理接口")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "queryString", value = "查询字符串", required = true, dataType = "String",
                    paramType = "query")
    })
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @GetMapping("/getListByQueryString")
    public R getListByQueryString(@RequestParam String queryString) {
        if (StringUtils.isEmpty(queryString)) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<Item> resultList = service.getListByQueryString(queryString);
        return R.ok().put("data", resultList);
    }

    @ApiOperation(value = "添加物品", notes = "添加物品", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "物品管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/addItem")
    public R addItem(@RequestBody Item item) {
        if (item == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkItem(item);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        item.setDeleteTag(false);
        item.setCreateBy(getCurrentUserLoginName());
        return service.addItem(item);
    }

    @ApiOperation(value = "修改物品", notes = "修改物品", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "物品管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/updateItem")
    public R updateItem(@RequestBody Item item) {
        if (item == null || item.getItemId() == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkItem(item);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        return service.updateItem(item);
    }

    @ApiOperation(value = "删除物品", notes = "删除物品，如果当前批次正在上报，并且有需求中需要此物品，不可删除，如果没有，逻辑删除，将单位一起逻辑删除",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "物品管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @DeleteMapping("/deleteItem")
    public R deleteItem(@RequestParam Integer itemId) {
        if (itemId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteItem(itemId);
    }

    private List<String> checkItem(Item item) {
        List<String> result = new ArrayList<>();
        if (item == null) {
            result.add("参数不能为空");
            return result;
        }
        if (item.getCateId() == null) {
            result.add("分类不能为空");
        }
        if (StringUtils.isEmpty(item.getItemName())) {
            result.add("物品名称不能为空");
        }
        if (StringUtils.isEmpty(item.getItemDescription())) {
            result.add("物品描述不能为空");
        }
        return result;
    }

}
