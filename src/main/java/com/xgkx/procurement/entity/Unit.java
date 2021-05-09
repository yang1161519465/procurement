package com.xgkx.procurement.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xgkx.procurement.common.annotation.GenerateWrapperType;
import com.xgkx.procurement.common.entity.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * b_bath
 * @author
 */
@ApiModel(value="Unit")
@Data
@TableName("b_unit")
public class Unit extends BaseEntity implements Serializable {
    /**
     * 单位id
     */
    @ApiModelProperty(value="单位id")
    @TableId(value = "unit_id", type = IdType.AUTO)
    private Integer unitId;

    /**
     * 单位名称
     */
    @ApiModelProperty(value="单位名称")
    @TableField("unit_name")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String unitName;

    /**
     * 物品id
     */
    @ApiModelProperty(value="物品id")
    @TableField("item_id")
    private Integer itemId;

    /**
     * 删除标记  0：未删除  1：已删除
     */
    @ApiModelProperty(value = "删除标记  0：未删除  1：已删除")
    @TableField("delete_tag")
    @GenerateWrapperType(value = GenerateWrapperType.Type.DEFAULT, defaultValue = false)
    private Boolean deleteTag;

    private static final long serialVersionUID = 1L;
}
