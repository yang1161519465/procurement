package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Item;
import com.xgkx.procurement.mapper.ItemMapper;
import com.xgkx.procurement.service.ItemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename ItemServiceImpl
 * @date 2021/4/27 16:38
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class ItemServiceImpl extends ServiceImpl<ItemMapper, Item> implements ItemService {
    @Override
    public List<Item> getListByCateId(Integer cateId) {
        QueryWrapper<Item> wrapper = new QueryWrapper<>();
        wrapper.eq("cate_id", cateId);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<Item> getListByQueryString(String queryString) {
        QueryWrapper<Item> wrapper = new QueryWrapper<>();
        wrapper.like("item_name", queryString);
        return baseMapper.selectList(wrapper);
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R addItem(Item item) {
        return null;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R updateItem(Item item) {
        return null;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R deleteItem(Integer itemId) {
        return null;
    }

    @Override
    public List<Item> getListByIds (List<Integer> itemIdList) {
        if (itemIdList == null || itemIdList.isEmpty()) {
            return new ArrayList<>();
        }
        QueryWrapper<Item> wrapper = new QueryWrapper<>();
        wrapper.in("item_id", itemIdList);
        return baseMapper.selectList(wrapper);
    }
}
