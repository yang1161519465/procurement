package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.service.serviceimpl.BathServiceImpl;
import com.xgkx.procurement.util.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 批次  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename BathController
 * @date 2021/4/27 16:47
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "批次管理接口", tags = "批次管理接口")
@Slf4j
@RestController
@RequestMapping("/bath")
public class BathController extends BaseController<Bath, Integer, BathServiceImpl> {

    @ApiOperation(value = "开启一个新的批次", notes = "开启一个新的批次", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "批次管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/openBath")
    public R openBath(@RequestBody Bath bath) {
        if (bath == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> result = checkParams(bath);
        if (!result.isEmpty()) {
            return R.error(StringUtils.listToString(result, "\n"));
        }
        bath.setCreateBy(getCurrentUserLoginName());
        return service.openBath(bath);
    }

    @ApiOperation(value = "修改批次信息", notes = "修改批次信息，批次已经停止，不允许修改",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "批次管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/updateBath")
    public R updateBath(@RequestBody Bath bath) {
        if (bath == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        if (bath.getBathId() == null) {
            return R.error("批次id不能为空");
        }
        List<String> result = checkParams(bath);
        if (!result.isEmpty()) {
            return R.error(StringUtils.listToString(result, "\n"));
        }
        bath.setUpdateBy(getCurrentUserLoginName());
        return service.updateBath(bath);
    }

    @ApiOperation(value = "删除批次信息", notes = "删除批次信息，如果当前批次存在需求，连带需求一起删除，已经到了结束时间的批次，不允许删除",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "批次管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @DeleteMapping("/deleteBathDeleteDemand")
    public R deleteBathDeleteDemand(@RequestParam Integer bathId) {
        if (bathId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteBath(bathId, true);
    }

    @ApiOperation(value = "删除批次信息", notes = "删除批次信息，如果当前批次存在需求，不删除，已经到了结束时间的批次，不允许删除",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "批次管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @DeleteMapping("/deleteBathNotDeleteDemand")
    public R deleteBathNotDeleteDemand(@RequestParam Integer bathId) {
        if (bathId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteBath(bathId, false);
    }

    /**
     * 检查批次类型是否全部填写
     *
     * @author 杨旭晨
     * @date 9:59 2021/5/9
     * @param bath:
     * @return java.lang.String[]
     **/
    private List<String> checkParams(Bath bath) {
        List<String> result = new ArrayList<>();
        if (bath == null) {
            result.add("对象不能为空");
            return result;
        }
        if (StringUtils.isEmpty(bath.getPathName())) {
            result.add("批次名称不能为空");
        }
        if (bath.getReportStartTime() == null) {
            result.add("开始时间不能为空");
        }
        if (bath.getReportStopTime() == null) {
            result.add("结束时间不能为空");
        }
        if (bath.getReportStopTime() != null && bath.getReportStartTime() != null && bath.getReportStartTime().isAfter(bath.getReportStopTime())) {
            result.add("开始时间不能再结束时间之后");
        }
        return result;
    }

}
