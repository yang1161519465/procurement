package com.xgkx.procurement.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xgkx.procurement.common.entity.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 用户权限表
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename UserRole
 * @date 14:51 2021/4/25
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@ApiModel(value="com.xgkx.procurement.entity.SUserRole")
@Data
@TableName("s_user_role")
public class UserRole extends BaseEntity implements Serializable {

    /**
     * 用户id
     */
    @ApiModelProperty(value="用户id")
    @TableId(value = "user_id", type = IdType.INPUT)
    private String userId;

    /**
     * 权限id
     */
    @ApiModelProperty(value="权限id")
    @TableId(value = "role_id", type = IdType.INPUT)
    private Integer roleId;

    private static final long serialVersionUID = 1L;
}
