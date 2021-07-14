package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.entity.Unit;
import com.xgkx.procurement.mapper.UnitMapper;
import com.xgkx.procurement.service.BathService;
import com.xgkx.procurement.service.DemandService;
import com.xgkx.procurement.service.UnitService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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

    @Autowired
    private BathService bathService;
    @Autowired
    private DemandService demandService;

    @Override
    public List<Unit> getListByItemId(Integer itemId) {
        QueryWrapper<Unit> wrapper = new QueryWrapper<>();
        wrapper.eq("item_id", itemId);
        return baseMapper.selectList(wrapper);
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R addUnit(Unit unit) {
        QueryWrapper<Unit> wrapper = new QueryWrapper<>();
        wrapper.eq("unit_name", unit.getUnitName())
                .eq("item_id", unit.getItemId());
        Unit selectUnit = baseMapper.selectOne(wrapper);
        if (selectUnit != null) {
            // 已经存在单位
            if (selectUnit.getDeleteTag()) {
                // 已经删除
                selectUnit.setDeleteTag(false);
                selectUnit.setUpdateBy(unit.getUpdateBy());
                return R.ok("添加成功！");
            }
            return R.error("单位已经存在，请勿重复添加！");
        }
        this.save(unit);
        return R.ok("添加成功！");
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R updateUnit(Unit unit) {
        this.updateById(unit);
        return R.ok("修改成功");
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R deleteItem(Integer unitId) {
        List<Bath> baths = bathService.getNowBath();
        if (baths != null && !baths.isEmpty()) {
            // 现在有进行中的批次，查找是否在批次中使用
            if (demandService.isUseUnitInBaths(unitId,
                    baths.stream().map(Bath::getBathId).collect(Collectors.toList()))) {
                // 在正在进行的批次中使用过，不允许删除
                return R.error( "该单位在当前批次中使用，不允许删除");
            }
        }
        // 现在没有有正在进行中的批次
        if (demandService.isUseUnit(unitId)) {
            // 使用过，逻辑删除
            Unit unit = this.getById(unitId);
            unit.setDeleteTag(true);
            this.updateById(unit);
            return R.ok("删除成功");
        } else {
            // 没有使用过，直接删除
            this.removeById(unitId);
            return R.ok("删除成功");
        }
    }

    @Override
    public List<Unit> getListByIds (List<Integer> unitIdList) {
        if (unitIdList == null || unitIdList.isEmpty()) {
            return new ArrayList<>();
        }
        QueryWrapper<Unit> wrapper = new QueryWrapper<>();
        wrapper.in("unit_id", unitIdList);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public boolean logicDeleteByItemId(Integer itemId) {
        QueryWrapper<Unit> wrapper = new QueryWrapper<>();
        wrapper.eq("item_id", itemId);
        List<Unit> unitList = baseMapper.selectList(wrapper);
        unitList.forEach(item -> item.setDeleteTag(true));
        this.updateBatchById(unitList);
        return true;
    }

    @Override
    public boolean deleteUnitByItemId(Integer itemId) {
        QueryWrapper<Unit> wrapper = new QueryWrapper<>();
        wrapper.eq("item_id", itemId);
        baseMapper.delete(wrapper);
        return true;
    }
}
