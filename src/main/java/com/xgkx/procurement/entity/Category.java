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
import java.util.List;

import lombok.Data;

/**
 * b_category  分类表
 *
 * @author
 */
@ApiModel(value = "Category")
@Data
@TableName("b_category")
public class Category extends BaseEntity implements Serializable {
    /**
     * 分类id
     */
    @ApiModelProperty(value = "分类id")
    @TableId(value = "cate_id", type = IdType.AUTO)
    private Integer cateId;

    /**
     * 父类id，若为0，则是顶级分类
     */
    @ApiModelProperty(value = "父类id，若为0，则是顶级分类")
    @TableField("parent_id")
    private Integer parentId;

    /**
     * 分类名称
     */
    @ApiModelProperty(value = "分类名称")
    @TableField("cate_name")
    private String cateName;

    /**
     * 排序序号
     */
    @ApiModelProperty(value = "排序序号")
    @TableField("seq")
    private Integer seq;

    /**
     * 子分类
     */
    @ApiModelProperty(value = "子分类")
    @TableField(exist = false)
    private List<Category> children;

    /**
     * 是否有子节点
     */
    @ApiModelProperty(value = "是否有子节点")
    @TableField(exist = false)
    private Boolean hasChildren;

    private static final long serialVersionUID = 1L;
}
