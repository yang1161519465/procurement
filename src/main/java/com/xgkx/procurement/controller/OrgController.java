package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.entity.Org;
import com.xgkx.procurement.service.serviceimpl.OrgServiceImpl;
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
 * 组织机构  控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename OrgController
 * @date 2021/4/27 16:43
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Api(value = "组织管理接口", tags = "组织管理接口")
@Slf4j
@RestController
@RequestMapping("/org")
public class OrgController extends BaseController<Org, Integer, OrgServiceImpl> {

    @ApiOperation(value = "添加组织", notes = "添加组织", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "组织管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/addOrg")
    public R addOrg(@RequestBody Org org) {
        if (org == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkOrg(org);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        org.setCreateBy(getCurrentUserLoginName());
        return service.addOrg(org);
    }

    @ApiOperation(value = "修改组织机构", notes = "修改组织机构", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE, tags = "组织管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @PostMapping("/upateOrg")
    public R upateOrg(@RequestBody Org org) {
        if (org == null || org.getOrgId() == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        List<String> checkResult = checkOrg(org);
        if (!checkResult.isEmpty()) {
            return R.error(StringUtils.listToString(checkResult, "\n"));
        }
        org.setUpdateBy(getCurrentUserLoginName());
        return service.updateOrg(org);
    }

    @ApiOperation(value = "删除组织机构", notes = "删除组织机构，组织机构中有人，不允许删除", consumes =
            MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE, tags = "组织管理接口")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN')")
    @DeleteMapping("/deleteOrg")
    public R deleteOrg(@RequestParam Integer orgId) {
        if (orgId == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return service.deleteOrg(orgId);
    }

    /**
     * 检查组织机构参数完整性
     *
     * @author 杨旭晨
     * @date 15:36 2021/5/9
     * @param org:
     * @return java.util.List<java.lang.String>
     **/
    private List<String> checkOrg(Org org) {
        List<String> result = new ArrayList<>();
        if (org == null) {
            result.add("参数不能为空");
            return result;
        }
        if (StringUtils.isEmpty(org.getOrgKey())) {
            result.add("组织机构唯一标识不能为空");
        }
        if (StringUtils.isEmpty(org.getOrgName())) {
            result.add("组织机构名称不能为空");
        }
        return result;
    }

}
