package com.xgkx.procurement.common.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.configuration.JwtPropreties;
import com.xgkx.procurement.constant.Constant;
import com.xgkx.procurement.constant.Msg;
import com.xgkx.procurement.util.JwtUtils;
import com.xgkx.procurement.util.ServletUtils;
import com.xgkx.procurement.util.WrapperUtil;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 基础控制器
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename BaseController
 * @date 2021/4/25 15:24
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public class BaseController<TEntity,PK,TService extends IService> {

    @Autowired
    protected TService service;
    @Autowired
    private JwtPropreties jwtPropreties;

    protected R toAjax(Boolean result) {
        return result ? R.ok() : R.error();
    }

    protected R toAjax(Integer result) {
        return result > 0 ? R.ok() : R.error();
    }

    @ApiOperation(value = "根据id获取对象", notes = "根据id获取对象", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
//    @ApiImplicitParam(name = "id", value = "主键", required = true, paramType = "query")
    @GetMapping("/")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'user')")
    public R getById(@RequestParam PK id) {
        if (id == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return R.ok().put("data", service.getById((Serializable)id));
    }

    @ApiOperation(value = "根据id更新对象", notes = "根据id更新对象", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
//    @ApiImplicitParams({
//            @ApiImplicitParam(name = "id", value = "主键", required = true, paramType = "query"),
//            @ApiImplicitParam(name = "entity", value = "要更新的对象", required = true, paramType = "body")
//    })
    @PutMapping("/")
    @PreAuthorize("hasAnyRole('DEV')")
    public R updateById(@RequestParam PK id, @RequestBody TEntity entity) {
        if (id == null || entity == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return toAjax(service.updateById(entity));
    }

    @ApiOperation(value = "根据id删除对象", notes = "根据id删除对象", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
//    @ApiImplicitParam(name = "id", value = "主键", required = true, paramType = "query")
    @DeleteMapping("/")
    @PreAuthorize("hasAnyRole('DEV')")
    public R deleteById(@RequestParam PK id) {
        if (id == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return toAjax(service.removeById((Serializable) id));
    }

    @ApiOperation(value = "插入对象", notes = "插入对象", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
//    @ApiImplicitParam(name = "entity", value = "要更新的对象", required = true, paramType = "body")
    @PostMapping("/")
    @PreAuthorize("hasAnyRole('DEV')")
    public R insert(@RequestBody TEntity entity) {
        if (entity == null) {
            return R.error(Msg.PARAMETER_NULL_MSG);
        }
        return toAjax(service.save(entity));
    }

    @ApiOperation(value = "根据查询条件查询列表", notes = "根据查询条件查询列表，给分页参数即为分页查询，不给就是查询全部",
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
//    @ApiImplicitParams({
//            @ApiImplicitParam(name = "entity", value = "查询对象", required = false, paramType = "body"),
//            @ApiImplicitParam(name = "pageNum", value = "查询第几页", required = false, paramType = "query"),
//            @ApiImplicitParam(name = "pageSize", value = "每页多少条", required = false, paramType = "query")
//    })
    @PostMapping("/list")
    @PreAuthorize("hasAnyRole('DEV', 'ADMIN', 'user')")
    public R getList(@RequestBody(required = false) TEntity entity,
                     @RequestParam(required = false) Integer pageSize,
                     @RequestParam(required = false) Integer pageNum) {
        if (entity == null) {
            // 查询参数为空，查询全部
            if (pageSize != null && pageNum != null && pageNum > 0 && pageSize > 0) {
                // 分页参数正确，分页查询
                PageHelper.startPage(pageNum,pageSize);
                List list = service.list();
                PageInfo<TEntity> result=new PageInfo<TEntity>(list);
                return R.ok().put("data", result);
            } else {
                // 分页参数不正确，返回全部列表
                List list = service.list();
                return R.ok().put("data", list);
            }
        } else {
            // 有查询参数，按照查询参数查找
            QueryWrapper<TEntity> wrapper = WrapperUtil.generateQueryWrapperFromObject(entity);
            if (pageSize != null && pageNum != null && pageNum > 0 && pageSize > 0) {
                // 分页参数正确，分页查询
                PageHelper.startPage(pageNum, pageSize);
                List list = service.list(wrapper);
                PageInfo<TEntity> result = new PageInfo<>(list);
                return R.ok().put("data", result);
            } else {
                // 分页参数不正确，返回按照查询参数查找的列表
                List list = service.list(wrapper);
                return R.ok().put("data", list);
            }
        }
    }

    protected HttpServletRequest getRequest() {
        return ServletUtils.getRequest();
    }

    protected String getCurrentUserId() {
        String token = getRequest().getHeader(Constant.TOKEN);
        String userId = null;
        try {
            userId = JwtUtils.getUserId(token, jwtPropreties.getSignature());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userId;
    }

    protected String getCurrentUserLoginName() {
        String token = getRequest().getHeader(Constant.TOKEN);
        String userName = null;
        try {
            userName = JwtUtils.getUserName(token, jwtPropreties.getSignature());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userName;
    }

}
