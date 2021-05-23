package com.xgkx.procurement.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xgkx.procurement.entity.Bath;

import java.util.List;


public interface BathMapper extends BaseMapper<Bath> {

    /**
     * 根据调价条件查询批次列表
     *
     * @author 杨旭晨
     * @date 15:14 2021/5/23
     * @param bath: 查询条件
     * @return java.util.List<com.xgkx.procurement.entity.Bath>
     **/
    List<Bath> getListByCategory (Bath bath);
}
