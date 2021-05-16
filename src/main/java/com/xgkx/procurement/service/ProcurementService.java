package com.xgkx.procurement.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.entity.Procurement;

/**
 * 采购  业务逻辑层
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename ProcurementService
 * @date 2021/4/27 16:34
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public interface ProcurementService extends IService<Procurement> {

    /**
     * 采购物品
     *
     * @author 杨旭晨
     * @date 17:21 2021/5/11
     * @param procurement:
     * @return com.xgkx.procurement.common.entity.R
     **/
    R purchaseItems (Procurement procurement);
}
