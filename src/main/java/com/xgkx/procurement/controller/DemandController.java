package com.xgkx.procurement.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.entity.Demand;
import com.xgkx.procurement.entity.User;
import com.xgkx.procurement.exception.BussinessException;
import com.xgkx.procurement.service.UserSerivce;
import com.xgkx.procurement.service.serviceimpl.DemandServiceImpl;
import com.xgkx.procurement.util.ServletUtils;
import com.xgkx.procurement.util.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 需求  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename DemandController
 * @date 2021/4/27 16:45
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "需求管理接口", tags = "需求管理接口")
@Slf4j
@RestController
@RequestMapping("/demand")
public class DemandController extends BaseController<Demand, Integer, DemandServiceImpl> {

    @Autowired
    private UserSerivce userSerivce;

    @ApiOperation(value = "提交一个需求", notes = "提交一个需求", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @PostMapping("/submitDemand")
    public R submitDemand(@RequestBody Demand demand) {
        if (demand == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkDemand(demand);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        // 设置组织机构信息
        User user = userSerivce.getById(getCurrentUserId());
        demand.setOrgId(user.getOrgId());
        demand.setCreateBy(getCurrentUserLoginName());
        return service.submitDemand(demand);
    }

    @ApiOperation(value = "获取我的组织及以下的需求列表", notes = "获取我的组织及以下的需求列表", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @GetMapping("/getMyOrgDemandList")
    public R getMyOrgDemandList(@RequestParam(required = false) Integer pageSize,
                                @RequestParam(required = false) Integer pageNum) {
        if (pageSize == null || pageNum == null) {
            // 获取全部
            return R.ok().put("data", service.getMyOrgDemandList(getCurrentUserId()));
        } else {
            // 分页获取
            PageHelper.startPage(pageNum, pageSize);
            List<Demand> demandList = service.getMyOrgDemandList(getCurrentUserId());
            PageInfo<Demand> result = new PageInfo<>(demandList);
            return R.ok().put("data", result);
        }
    }

    @ApiOperation(value = "获取需求列表", notes = "获取需求列表", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @PostMapping("/getList")
    public R getList(@RequestParam(required = false) Integer pageSize,
                     @RequestParam(required = false) Integer pageNum,
                     @RequestBody(required = false) Demand demand) {
        if (demand == null) {
            // 查询参数为空，查询全部
            if (pageSize != null && pageNum != null && pageNum > 0 && pageSize > 0) {
                // 分页参数正确，分页查询
                PageHelper.startPage(pageNum,pageSize);
                List list = service.getList(new Demand());
                PageInfo<Demand> result=new PageInfo<Demand>(list);
                return R.ok().put("data", result);
            } else {
                // 分页参数不正确，返回全部列表
                List list = service.getList(new Demand());
                return R.ok().put("data", list);
            }
        } else {
            // 有查询参数，按照查询参数查找
            if (pageSize != null && pageNum != null && pageNum > 0 && pageSize > 0) {
                // 分页参数正确，分页查询
                PageHelper.startPage(pageNum, pageSize);
                List list = service.getList(demand);
                PageInfo<Demand> result = new PageInfo<>(list);
                return R.ok().put("data", result);
            } else {
                // 分页参数不正确，返回按照查询参数查找的列表
                List list = service.getList(demand);
                return R.ok().put("data", list);
            }
        }
    }

    @ApiOperation(value = "根据批次id获取该批次的统计", notes = "根据批次id获取该批次的统计，可以根据不同的组织机构分别统计", consumes =
            MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @GetMapping("/statisticsByBathId")
    public R statisticsByBathId(@RequestParam Integer bathId, @RequestParam(required = false) Integer orgId) {
        if (bathId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        Bath result = service.statisticsByBathId(bathId, orgId);
        return R.ok().put("data", result);
    }

    @ApiOperation(value = "修改需求", notes = "修改需求", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @PostMapping("/updateDemand")
    public R updateDemand(@RequestBody Demand demand) {
        if (demand == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> result = checkDemand(demand);
        if (!result.isEmpty()) {
            return R.error(StringUtils.listToString(result, "\n"));
        }
        if (demand.getDemandId() == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        demand.setUpdateBy(getCurrentUserLoginName());
        return service.updateDemand(demand);
    }

    @ApiOperation(value = "删除需求", notes = "删除需求", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @DeleteMapping("/deleteDemand")
    public R deleteDemand(@RequestParam Integer demandId) {
        if (demandId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteDemand(demandId);
    }

    @ApiOperation(value = "给予需求", notes = "给予需求", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @PostMapping("/giveDemand")
    public R giveDemand(@RequestParam Integer demandId) {
        if (demandId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.giveDemand(demandId);
    }

    @ApiOperation(value = "导出我所在组织的指定批次的需求", notes = "导出我所在组织的指定批次的需求", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "需求管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @PostMapping("/exprotPdf")
    public void exprotPdf(@RequestParam Integer bathId, @RequestBody JSONObject data, HttpServletResponse response) throws IOException {
        if (bathId == null || data == null) {
            throw new BussinessException(Msg.PARAMETER_NULL_MSG);
        }
        String fileUrl = service.exprotPdf(bathId, data, getCurrentUserId());
        if (fileUrl == "") {
            return;
        }
        File file = new File(fileUrl);
        ServletUtils.returnFile(response, file);
        return;
    }

    private List<String> checkDemand(Demand demand) {
        List<String> result = new ArrayList<>();
        if (demand == null) {
            result.add("参数不能为空");
            return result;
        }
        if (demand.getCount() == null) {
            result.add("数量不能为空");
        }
        if (demand.getCount() <= 0) {
            result.add("数量必须为正数");
        }
        if (demand.getBathId() == null) {
            result.add("批次不能为空");
        }
        if (demand.getItemId() == null) {
            result.add("物品不能为空");
        }
        if (demand.getUnitId() == null) {
            result.add("单位不能为空");
        }
        return result;
    }

}
