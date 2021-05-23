package com.xgkx.procurement.const_enum;

/**
 * 批次状态枚举
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename BathStatusEnum
 * @date 2021/5/23 15:20
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public enum BathStatusEnum {

    /**
     * 上报中
     */
    REPORTING(0, "上报中"),
    /**
     * 采购中
     */
    PURCHASING(1, "采购中"),
    /**
     * 已结束
     */
    OVER(2, "已结束"),
    /**
     * 未开始
     */
    HASNOTSTARTED(3, "未开始");

    private Integer code;
    private String description;

    BathStatusEnum (Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    public Integer getCode () {
        return code;
    }

    public String getDescription () {
        return description;
    }
}
