package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Unit;
import com.xgkx.procurement.service.serviceimpl.UnitServiceImpl;
import io.swagger.annotations.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

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
}
