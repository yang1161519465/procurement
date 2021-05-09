package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Bath;

/**
 * 采购批次  业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename BathService
 * @date 2021/4/27 16:40
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface BathService extends IService<Bath> {

    /**
     * 开启一个新的批次
     *
     * @author 杨旭晨
     * @date 10:07 2021/5/9
     * @param bath: 需求
     * @return com.xgkx.procurement.common.entity.R
     **/
    R openBath(Bath bath);

    /**
     * 更新批次
     *
     * @author 杨旭晨
     * @date 10:14 2021/5/9
     * @param bath:  要更新的批次
     * @return com.xgkx.procurement.common.entity.R
     **/
    R updateBath(Bath bath);

    /**
     * 删除批次信息
     *
     * @author 杨旭晨
     * @date 10:19 2021/5/9
     * @param bathId: 要删除的批次id
     * @param isDeleteDemand: 是否级联删除需求
     * @return com.xgkx.procurement.common.entity.R
     **/
    R deleteBath(Integer bathId, Boolean isDeleteDemand);
}
