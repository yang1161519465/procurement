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
 * b_item
 * @author
 */
@ApiModel(value="Item")
@Data
@TableName("b_item")
public class Item extends BaseEntity implements Serializable {
    /**
     * 物品id
     */
    @ApiModelProperty(value="物品id")
    @TableId(value = "item_id", type = IdType.AUTO)
    private Integer itemId;

    /**
     * 物品名称
     */
    @ApiModelProperty(value="物品名称")
    @TableField("item_name")
    private String itemName;

    /**
     * 分类id
     */
    @ApiModelProperty(value="分类id")
    @TableField("cate_id")
    private Integer cateId;

    /**
     * 物品描述
     */
    @ApiModelProperty(value = "物品描述")
    @TableField("item_description")
    private String itemDescription;

    /**
     * 排序序号
     */
    @ApiModelProperty(value="排序序号")
    @TableField("seq")
    private Integer seq;

    /**
     * 删除标记  0：未删除  1：已删除
     */
    @ApiModelProperty(value = "删除标记  0：未删除  1：已删除")
    @TableField("delete_tag")
    @GenerateWrapperType(value = GenerateWrapperType.Type.DEFAULT, defaultValue = false)
    private Boolean deleteTag;

    private static final long serialVersionUID = 1L;
}
