package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.entity.Procurement;
import com.xgkx.procurement.mapper.ProcurementMapper;
import com.xgkx.procurement.service.ProcurementService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename ProcurementServiceImpl
 * @date 2021/4/27 16:35
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class ProcurementServiceImpl extends ServiceImpl<ProcurementMapper, Procurement> implements ProcurementService {
}
