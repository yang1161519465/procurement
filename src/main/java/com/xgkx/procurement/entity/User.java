package com.xgkx.procurement.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xgkx.procurement.common.annotation.GenerateWrapperType;
import com.xgkx.procurement.common.entity.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
 * 用户表
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename User
 * @date 14:50 2021/4/25
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@ApiModel(value="User")
@Data
@TableName("s_user")
public class User extends BaseEntity implements Serializable {

    /**
     * 用户id
     */
    @ApiModelProperty(value="用户id")
    @TableId(value = "user_id", type = IdType.ID_WORKER_STR)
    private String userId;

    /**
     * 用户名称
     */
    @ApiModelProperty(value="用户名称")
    @TableField("user_name")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String userName;

    /**
     * 登录名
     */
    @ApiModelProperty(value="登录名")
    @TableField("login_name")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String loginName;

    /**
     * 组织机构id，如果为0，则是开发人员
     */
    @ApiModelProperty(value = "组织机构id")
    @TableField("org_id")
    private Integer orgId;

    /**
     * 密码 md5加密
     */
    @ApiModelProperty(value="密码 md5加密")
    @TableField("password_md5")
    private String passwordMd5;

    /**
     * 联系电话
     */
    @ApiModelProperty(value="联系电话")
    @TableField("phone_num")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String phoneNum;

    /**
     * 电子邮箱
     */
    @ApiModelProperty(value="电子邮箱")
    @TableField("email")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String email;

    /**
     * 用户拥有的权限列表
     */
    @ApiModelProperty(value = "用户权限列表")
    @TableField(exist = false)
    private List<Role> roles;

    /**
     * 密码，未加密的
     */
    @ApiModelProperty(value = "未加密的密码")
    @TableField(exist = false)
    private String password;

    private static final long serialVersionUID = 1L;
}
