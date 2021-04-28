package com.xgkx.procurement.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xgkx.procurement.common.entity.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * b_demand  需求表
 * @author
 */
@ApiModel(value="Demand")
@Data
@TableName("demand")
public class Demand extends BaseEntity implements Serializable {
    /**
     * 需求id
     */
    @ApiModelProperty(value="需求id")
    @TableId(value = "demand_id", type = IdType.AUTO)
    private Integer demandId;

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
     * 需求数量
     */
    @ApiModelProperty(value="需求数量")
    @TableField("count")
    private Integer count;

    /**
     * 组织id
     */
    @ApiModelProperty(value="组织id")
    @TableField("org_id")
    private Integer orgId;

    /**
     * 批次id
     */
    @ApiModelProperty(value="批次id")
    @TableField("bath_id")
    private Integer bathId;

    /**
     * 是否给予
     */
    @ApiModelProperty(value="是否给予")
    @TableField("is_meet")
    private Boolean isMeet;

    private static final long serialVersionUID = 1L;
}
