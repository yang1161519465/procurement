package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Unit;
import com.xgkx.procurement.mapper.UnitMapper;
import com.xgkx.procurement.service.UnitService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UnitServiceImpl
 * @date 2021/4/27 16:33
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class UnitServiceImpl extends ServiceImpl<UnitMapper, Unit> implements UnitService {
    @Override
    public List<Unit> getListByItemId(Integer itemId) {
        QueryWrapper<Unit> wrapper = new QueryWrapper<>();
        wrapper.eq("item_id", itemId);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public R addUnit(Unit unit) {
        return null;
    }

    @Override
    public R updateUnit(Unit unit) {
        return null;
    }

    @Override
    public R deleteItem(Integer unitId) {
        return null;
    }
}
