package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.entity.UserRole;
import com.xgkx.procurement.mapper.UserRoleMapper;
import com.xgkx.procurement.service.UserRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @copyright (C), 2019-2021, 河北地质大学
 * @author 杨旭晨
 * @filename UserRoleServiceImpl
 * @date 2021/5/4 17:01
 * @history
 * <author>     <time>      <version>       <desc>
 *  作者名       修改时间       版本号           描述
**/
@Service
@Transactional(readOnly = true)
@Slf4j
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {


}
