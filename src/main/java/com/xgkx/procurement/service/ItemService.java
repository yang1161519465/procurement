package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
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
}
