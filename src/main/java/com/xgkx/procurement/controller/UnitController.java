package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.entity.Unit;
import com.xgkx.procurement.service.serviceimpl.UnitServiceImpl;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
