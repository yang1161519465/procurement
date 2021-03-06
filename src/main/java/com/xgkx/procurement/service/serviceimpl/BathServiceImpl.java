package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.const_enum.BathStatusEnum;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.entity.Demand;
import com.xgkx.procurement.mapper.BathMapper;
import com.xgkx.procurement.service.BathService;
import com.xgkx.procurement.service.DemandService;
import com.xgkx.procurement.util.DateTimeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

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

    @Autowired
    private DemandService demandService;

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R openBath(Bath bath) {
        return save(bath) ? R.ok() : R.error("服务器错误");
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R updateBath(Bath bath) {
        if (bath.getReportStopTime().isBefore(DateTimeUtils.getCurrentLocalDateTime())) {
            return R.error("批次已经停止上报，禁止修改");
        }
        return updateById(bath) ? R.ok() :  R.error("服务器错误");
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R deleteBath(Integer bathId, Boolean isDeleteDemand) {
        Bath bath = getById(bathId);
        if (bath == null) {
            return R.error("已经删除，请不要重复点击");
        }
        if (bath.getReportStopTime().isBefore(DateTimeUtils.getCurrentLocalDateTime())) {
            return R.error("已经到了批次截止时间，不允许删除");
        }
        List<Demand> demandList = demandService.getListByBathId(bathId);
        if (demandList.isEmpty()) {
            // 不存在需求提交，直接删除
            removeById(bathId);
        } else {
            // 存在需求提交，需要判断是否删除需求
            if (isDeleteDemand) {
                // 删除需求
                demandService.removeByIds(demandList.stream().map(Demand::getDemandId).collect(Collectors.toList()));
                removeById(bathId);
            } else {
                // 不删除需求
                return R.ok("该批次已经有机构提交了需求，请确认");
            }
        }
        return R.ok();
    }

    @Override
    public List<Bath> getListByCategory (Bath bath) {
        List<Bath> bathList = baseMapper.getListByCategory(bath);
        for (Bath item : bathList) {
            setBathStatus(item);
        }
        return bathList;
    }

    @Override
    public List<Bath> getNowBath() {
        QueryWrapper<Bath> wrapper = new QueryWrapper<>();
        wrapper.gt("report_start_time", DateTimeUtils.getCurrentLocalDateTime())
                .lt("report_stop_time", DateTimeUtils.getCurrentLocalDateTime());
        List<Bath> baths = baseMapper.selectList(wrapper);
        return baths;
    }

    private void setBathStatus(Bath bath) {
        if (bath.getReportStartTime().isAfter(DateTimeUtils.getCurrentLocalDateTime())) {
            // 还没有开始
            bath.setBathStatus(BathStatusEnum.HASNOTSTARTED.getCode());
        } else if (bath.getReportStartTime().isBefore(DateTimeUtils.getCurrentLocalDateTime()) &&
            bath.getReportStopTime().isAfter(DateTimeUtils.getCurrentLocalDateTime())) {
            // 上报中
            bath.setBathStatus(BathStatusEnum.REPORTING.getCode());
        } else if (bath.getReportStopTime().isBefore(DateTimeUtils.getCurrentLocalDateTime())) {
            // 已结束
            bath.setBathStatus(BathStatusEnum.OVER.getCode());
        }
    }

}
