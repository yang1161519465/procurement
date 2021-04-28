package com.xgkx.procurement.controller;

import com.xgkx.procurement.common.controller.BaseController;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.service.serviceimpl.BathServiceImpl;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
