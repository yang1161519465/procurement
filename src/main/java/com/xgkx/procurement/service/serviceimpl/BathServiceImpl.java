package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.mapper.BathMapper;
import com.xgkx.procurement.service.BathService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename BathServiceImpl
 * @date 2021/4/27 16:40
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class BathServiceImpl extends ServiceImpl<BathMapper, Bath> implements BathService {
}
