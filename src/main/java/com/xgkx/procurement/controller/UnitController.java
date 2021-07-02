package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Unit;
import com.xgkx.procurement.service.serviceimpl.UnitServiceImpl;
import com.xgkx.procurement.util.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 单位  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UnitController
 * @date 2021/4/27 16:41
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "单位管理接口", tags = "单位管理接口")
@Slf4j
@RestController
@RequestMapping("/unit")
public class UnitController extends BaseController<Unit, Integer, UnitServiceImpl> {

    @ApiOperation(value = "根据itemId查询实体信息", notes = "根据itemId查询实体信息", produces = MediaType.APPLICATION_JSON_VALUE,
            tags = "单位管理接口")
    @ApiImplicitParam(name = "itemId", value = "物品Id", required = true, dataType = "Integer", paramType =
            "query")
    @GetMapping("getByItemId")
    public R getByItemId(@RequestParam Integer itemId) {
        if (itemId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<Unit> list = service.getListByItemId(itemId);
        return R.ok().put("data", list);
    }

    @ApiOperation(value = "添加单位", notes = "添加单位", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "单位管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/addUnit")
    public R addUnit(@RequestBody Unit unit) {
        if (unit == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkUnit(unit);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        unit.setDeleteTag(false);
        unit.setCreateBy(getCurrentUserLoginName());
        return service.addUnit(unit);
    }

    @ApiOperation(value = "修改单位", notes = "修改单位", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "单位管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/updateUnit")
    public R updateUnit(@RequestBody Unit unit) {
        if (unit == null || unit.getUnitId() == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkUnit(unit);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        unit.setUpdateBy(getCurrentUserLoginName());
        return service.updateUnit(unit);
    }

    @ApiOperation(value = "删除单位", notes = "删除单位，如果有正在进行中的批次正在使用，不允许删除，如果有已经截止的批次使用，逻辑删除",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "单位管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @DeleteMapping("/deleteItem")
    public R deleteItem(@RequestParam Integer unitId) {
        if (unitId == null ) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteItem(unitId);
    }

    @ApiOperation(value = "根据物品id获取单位列表", notes = "根据物品id获取单位列表",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "单位管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @GetMapping("/getListByItemId")
    public R getListByItemId(@RequestParam Integer itemId) {
        if (itemId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return R.ok().put("data", service.getListByItemId(itemId));
    }

        private List<String> checkUnit(Unit unit) {
        List<String> result = new ArrayList<>();
        if (unit == null) {
            result.add("参数不能为空");
            return result;
        }
        if (unit.getItemId() == null) {
            result.add("对应物品不能为空");
        }
        if (StringUtils.isEmpty(unit.getUnitName())) {
            result.add("单位名称不能为空");
        }
        return result;
    }
}
