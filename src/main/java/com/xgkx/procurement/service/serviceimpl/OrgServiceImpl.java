package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.entity.Org;
import com.xgkx.procurement.mapper.OrgMapper;
import com.xgkx.procurement.service.OrgService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename OrgServiceImpl
 * @date 2021/4/27 16:36
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class OrgServiceImpl extends ServiceImpl<OrgMapper, Org> implements OrgService {
    @Override
    public List<Org> getListByOrgIds(List<Integer> orgIds) {
        QueryWrapper<Org> wrapper = new QueryWrapper<>();
        wrapper.in("org_id", orgIds);
        return baseMapper.selectList(wrapper);
    }
}
