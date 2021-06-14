package com.xgkx.procurement.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xgkx.procurement.entity.Procurement;

import java.util.List;

public interface ProcurementMapper extends BaseMapper<Procurement> {

    /**
     * 按照条件查找采购
     *
     * @author 杨旭晨
     * @date 15:54 2021/6/13
     * @param procurement: 查询条件
     * @return java.util.List<com.xgkx.procurement.entity.Procurement>
     **/
    List<Procurement> getProList(Procurement procurement);

}
