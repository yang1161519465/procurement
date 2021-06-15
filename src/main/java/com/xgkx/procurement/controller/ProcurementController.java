package com.xgkx.procurement.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Procurement;
import com.xgkx.procurement.entity.User;
import com.xgkx.procurement.service.UserSerivce;
import com.xgkx.procurement.service.serviceimpl.ProcurementServiceImpl;
import com.xgkx.procurement.util.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 采购   控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename ProcurementController
 * @date 2021/4/27 16:42
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "采购管理接口", tags = "采购管理接口")
@Slf4j
@RestController
@RequestMapping("/procurement")
public class ProcurementController extends BaseController<Procurement, Integer, ProcurementServiceImpl> {

    @Autowired
    private UserSerivce userSerivce;

    @ApiOperation(value = "采购物品", notes = "采购物品", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "采购管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/purchaseItems")
    public R purchaseItems(@RequestBody Procurement procurement) {
        if (procurement == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkList = checkProcurement(procurement);
        if (!checkList.isEmpty()) {
            return R.error(StringUtils.listToString(checkList, "\n"));
        }
        User user = userSerivce.getById(getCurrentUserId());
        procurement.setCreateBy(getCurrentUserLoginName());
        procurement.setOrgId(user.getOrgId());
        return service.purchaseItems(procurement);
    }

    @ApiOperation(value = "获取采购的列表", notes = "获取采购的列表", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "采购管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/getProList")
    public R getProList(@RequestBody(required = false) Procurement procurement,
                        @RequestParam(required = false) Integer pageSize,
                        @RequestParam(required = false) Integer pageNum) {
        if (procurement == null) {
            // 查询全部
            if (pageSize != null && pageNum != null && pageSize > 0 && pageNum > 0) {
                // 分页查询
                PageHelper.startPage(pageNum, pageSize);
                List<Procurement> list = service.getProList(new Procurement());
                PageInfo<Procurement> result = new PageInfo<>(list);
                return R.ok().put("data", result);
            } else {
                List<Procurement> list = service.getProList(new Procurement());
                return R.ok().put("data", list);
            }
        } else {
            // 按照条件查询
            if (pageSize != null && pageNum != null && pageSize > 0 && pageNum > 0) {
                // 分页查询
                PageHelper.startPage(pageNum, pageSize);
                List<Procurement> list = service.getProList(procurement);
                PageInfo<Procurement> result = new PageInfo<>(list);
                return R.ok().put("data", result);
            } else {
                List<Procurement> list = service.getProList(procurement);
                return R.ok().put("data", list);
            }
        }
    }

    @ApiOperation(value = "修改采购物品", notes = "修改采购物品", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "采购管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
    @PostMapping("/updatePro")
    public R updatePro(@RequestBody Procurement procurement) {
        if (procurement == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkList = checkProcurement(procurement);
        if (!checkList.isEmpty()) {
            return R.error(StringUtils.listToString(checkList, "\n"));
        }
        return service.updatePro(procurement);
    }

//    @ApiOperation(value = "", notes = "修改采购物品", consumes = MediaType.APPLICATION_JSON_VALUE,
//            produces = MediaType.APPLICATION_JSON_VALUE, tags = "采购管理接口")
//    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'USER')")
//    @PostMapping("/updatePro")
//    public R updatePro(@RequestBody Procurement procurement) {
//        if (procurement == null) {
//            return R.error(Msg.PARAMETER_NULL_MSG);
//        }
//        List<String> checkList = checkProcurement(procurement);
//        if (!checkList.isEmpty()) {
//            return R.error(StringUtils.listToString(checkList, "\n"));
//        }
//        return service.updatePro(procurement);
//    }

    /**
     * 检查采购对象数据完整性
     *
     * @author 杨旭晨
     * @date 17:17 2021/5/11
     * @param procurement:
     * @return java.util.List<java.lang.String>
     **/
    private List<String> checkProcurement (Procurement procurement) {
        List<String> result = new ArrayList<>();
        if (procurement == null) {
            result.add("参数不能为空");
            return result;
        }
        if (procurement.getItemId() == null) {
            result.add("物品为空");
        }
        if (procurement.getUnitId() == null) {
            result.add("单位为空");
        }
        if (procurement.getPrice() == null) {
            result.add("单价为空");
        }
        return result;
    }

}
