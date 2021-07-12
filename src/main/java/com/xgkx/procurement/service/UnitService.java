package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Unit;

import java.util.List;

/**
 * 单位  业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UnitService
 * @date 2021/4/27 16:32
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface UnitService extends IService<Unit> {

    /**
     * 根据物品id获取单位
     *
     * @author 杨旭晨
     * @date 11:27 2021/5/1
     * @param itemId: 物品id
     * @return java.util.List<com.xgkx.procurement.entity.Unit>
     **/
    List<Unit> getListByItemId(Integer itemId);

    /**
     * 添加一个单位
     *
     * @author 杨旭晨
     * @date 15:52 2021/5/9
     * @param unit: 要添加的单位
     * @return com.xgkx.procurement.common.entity.R
     **/
    R addUnit(Unit unit);

    /**
     * 修改单位
     *
     * @author 杨旭晨
     * @date 15:55 2021/5/9
     * @param unit:
     * @return com.xgkx.procurement.common.entity.R
     **/
    R updateUnit(Unit unit);

    /**
     * 删除单位
     * 1.如果有正在上报的批次中使用，不允许删除粗
     * 2.如果有已经停止的需求使用，逻辑删除
     *
     * @author 杨旭晨
     * @date 15:56 2021/5/9
     * @param unitId: 单位id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R deleteItem(Integer unitId);

    /**
     * 根据id列表获取列表
     *
     * @author 杨旭晨
     * @date 10:38 2021/5/21
     * @param unitIdList: id列表
     * @return java.util.List<com.xgkx.procurement.entity.Unit>
     **/
    List<Unit> getListByIds (List<Integer> unitIdList);

    /**
     * 根据物品id，逻辑删除物品单位
     *
     * @author 杨旭晨
     * @date 2021/7/8 17:36
     * @param itemId:
     * @return boolean
    **/
    boolean logicDeleteByItemId(Integer itemId);

    /**
     * 根据物品id，删除单位
     *
     * @author 杨旭晨
     * @date 2021/7/8 17:40
     * @param itemId: 物品id
     * @return boolean
    **/
    boolean deleteUnitByItemId(Integer itemId);
}
