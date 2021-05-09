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
 * s_org
 * @author
 */
@ApiModel(value="Org")
@Data
@TableName("s_org")
public class Org extends BaseEntity implements Serializable {
    /**
     * 组织机构id
     */
    @ApiModelProperty(value="组织机构id")
    @TableId(value = "org_id", type = IdType.AUTO)
    private Integer orgId;

    /**
     * 组织机构名称
     */
    @ApiModelProperty(value="组织机构名称")
    @TableField("org_name")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String orgName;

    /**
     * 组织机构唯一编码
     */
    @ApiModelProperty(value="组织机构唯一编码")
    @TableField("org_key")
    private String orgKey;

    /**
     * 删除标记  0：未删除  1：已删除
     */
    @ApiModelProperty(value = "删除标记  0：未删除  1：已删除")
    @TableField("delete_tag")
    @GenerateWrapperType(value = GenerateWrapperType.Type.DEFAULT, defaultValue = false)
    private Boolean deleteTag;

    private static final long serialVersionUID = 1L;
}
