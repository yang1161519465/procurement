package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Item;

import java.util.List;

/**
 * 物品  业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename ItemService
 * @date 2021/4/27 16:37
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface ItemService extends IService<Item> {

    /**
     * 根据分类id，来获取物品列表
     *
     * @author 杨旭晨
     * @date 9:02 2021/4/29
     * @param cateId:
     * @return java.util.List<com.xgkx.procurement.entity.Item>
     **/
    List<Item> getListByCateId(Integer cateId);

    /**
     * 根据查询字符串，查询物品列表，查询物品名称
     *
     * @author 杨旭晨
     * @date 9:04 2021/4/29
     * @param queryString:
     * @return java.util.List<com.xgkx.procurement.entity.Item>
     **/
    List<Item> getListByQueryString(String queryString);

    /**
     * 添加一个物品
     *
     * @author 杨旭晨
     * @date 15:12 2021/5/9
     * @param item: 要添加的物品信息
     * @return com.xgkx.procurement.common.entity.R
     **/
    R addItem(Item item);

    /**
     * 更新物品
     *
     * @author 杨旭晨
     * @date 15:14 2021/5/9
     * @param item: 要修改的物品
     * @return com.xgkx.procurement.common.entity.R
     **/
    R updateItem(Item item);

    /**
     * 删除物品
     * 1.判断当前正在上报的批次中是否有需求需要此物品，如果有，不允许删除
     * 2.如果没有在任何地方引用到，真删除
     * 3.逻辑删除，将物品对应单位一起删除
     *
     * @author 杨旭晨
     * @date 15:16 2021/5/9
     * @param itemId: 要删除的物品id
     * @return com.xgkx.procurement.common.entity.R
     **/
    R deleteItem(Integer itemId);
}
