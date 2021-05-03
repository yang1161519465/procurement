package com.xgkx.procurement.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xgkx.procurement.common.entity.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import lombok.Data;

/**
 * b_procurement  采购表
 * @author
 */
@ApiModel(value="Procurement")
@Data
@TableName("b_procurement")
public class Procurement extends BaseEntity implements Serializable {
    /**
     * 采购id
     */
    @ApiModelProperty(value="采购id")
    @TableId(value = "pro_id", type = IdType.AUTO)
    private Integer proId;

    /**
     * 采购时间
     */
    @ApiModelProperty(value="采购时间")
    @TableField("pro_time")
    private LocalDateTime proTime;

    /**
     * 组织id
     */
    @ApiModelProperty(value="组织id")
    @TableField("org_id")
    private Integer orgId;

    /**
     * 物品id
     */
    @ApiModelProperty(value="物品id")
    @TableField("item_id")
    private Integer itemId;

    /**
     * 单位id
     */
    @ApiModelProperty(value="单位id")
    @TableField("unit_id")
    private Integer unitId;

    /**
     * 单价
     */
    @ApiModelProperty(value="单价")
    @TableField("price")
    private BigDecimal price;

    /**
     * 采购数量
     */
    @ApiModelProperty(value="采购数量")
    @TableField("count")
    private Integer count;

    /**
     * 是否下单
     */
    @ApiModelProperty(value="是否下单")
    @TableField("is_pay")
    private Boolean isPay;

    /**
     * 是否到货
     */
    @ApiModelProperty(value="是否到货")
    @TableField("is_arrive")
    private Boolean isArrive;

    /**
     * 总花费
     */
    @ApiModelProperty(value="总花费")
    @TableField("cost")
    private BigDecimal cost;

    private static final long serialVersionUID = 1L;
}
