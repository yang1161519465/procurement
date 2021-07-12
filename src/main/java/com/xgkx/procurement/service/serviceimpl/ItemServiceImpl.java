package com.xgkx.procurement.service.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Bath;
import com.xgkx.procurement.entity.Item;
import com.xgkx.procurement.mapper.ItemMapper;
import com.xgkx.procurement.service.BathService;
import com.xgkx.procurement.service.DemandService;
import com.xgkx.procurement.service.ItemService;
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
 * @filename ItemServiceImpl
 * @date 2021/4/27 16:38
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Service
@Transactional(readOnly = true)
@Slf4j
public class ItemServiceImpl extends ServiceImpl<ItemMapper, Item> implements ItemService {

    @Autowired
    private BathService bathService;
    @Autowired
    private DemandService demandService;
    @Autowired
    private UnitService unitService;

    @Override
    public List<Item> getListByCateId(Integer cateId) {
        QueryWrapper<Item> wrapper = new QueryWrapper<>();
        wrapper.eq("cate_id", cateId);
        wrapper.eq("delete_flag", false);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<Item> getListByQueryString(String queryString) {
        QueryWrapper<Item> wrapper = new QueryWrapper<>();
        wrapper.like("item_name", queryString);
        wrapper.eq("delete_flag", false);
        return baseMapper.selectList(wrapper);
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R addItem(Item item) {
        // 查找数据库中是否存在物品
        QueryWrapper<Item> wrapper = new QueryWrapper<>();
        wrapper.eq("item_name", item.getItemName())
                .eq("item_description", item.getItemDescription());
        Item dbItem = baseMapper.selectOne(wrapper);
        if (dbItem != null) {
            // 已经存在
            if (!dbItem.getDeleteTag()) {
                // 未删除，重复
                return R.error("该物品已经存在，请勿重复添加");
            }
            dbItem.setDeleteTag(false);
            this.updateById(dbItem);
            return R.ok("添加成功");
        }
        this.save(item);
        return R.ok("添加成功");
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R updateItem(Item item) {
        this.updateById(item);
        return R.ok();
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public R deleteItem(Integer itemId) {
        List<Bath> baths = bathService.getNowBath();
        if (baths != null && !baths.isEmpty()) {
            // 现在有进行中的批次，查找是否在批次中使用
            if (demandService.isUseItemInBaths(itemId,
                    baths.stream().map(Bath::getBathId).collect(Collectors.toList()))) {
                // 在正在进行的批次中使用过，不允许删除
                return R.error( "该物品在当前批次中使用，不允许删除");
            }
        }
        if (demandService.isUseItem(itemId)) {
            // 在批次中使用过，逻辑删除
            Item item = this.getById(itemId);
            item.setDeleteTag(true);
            // 将单位逻辑删除
            unitService.logicDeleteByItemId(itemId);
            this.updateById(item);
            return R.ok("删除成功");
        }
        // 没有使用过，直接删除
        // 直接删除单位
        unitService.deleteUnitByItemId(itemId);
        this.removeById(itemId);
        return R.ok("删除成功");
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
