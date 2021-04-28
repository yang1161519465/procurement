package com.xgkx.procurement.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xgkx.procurement.common.annotation.GenerateWrapperType;
import com.xgkx.procurement.common.entity.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 权限表
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename Role
 * @date 14:48 2021/4/25
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@ApiModel(value="com.xgkx.procurement.entity.Role")
@Data
@TableName("s_role")
public class Role extends BaseEntity implements Serializable {
    /**
     * 权限id
     */
    @ApiModelProperty(value="权限id")
    @TableId(value = "role_id", type = IdType.AUTO)
    private Integer roleId;

    /**
     * 权限key
     */
    @ApiModelProperty(value="权限key")
    @TableField("role_key")
    private String roleKey;

    /**
     * 权限名称
     */
    @ApiModelProperty(value="权限名称")
    @TableField("role_name")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String roleName;



    private static final long serialVersionUID = 1L;
}
