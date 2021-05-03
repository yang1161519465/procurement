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
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * b_bath  采购批次表
 * @author
 */
@ApiModel(value="Bath")
@Data
@TableName("b_bath")
public class Bath extends BaseEntity implements Serializable {
    /**
     * 采购批次id
     */
    @ApiModelProperty(value="采购批次id")
    @TableId(value = "bath_id", type = IdType.AUTO)
    private Integer bathId;

    /**
     * 批次名称
     */
    @ApiModelProperty(value="批次名称")
    @TableField("path_name")
    @GenerateWrapperType(value = GenerateWrapperType.Type.LIKE)
    private String pathName;

    /**
     * 开始上报时间
     */
    @ApiModelProperty(value="开始上报时间")
    @TableField("report_start_time")
    private LocalDateTime reportStartTime;

    /**
     * 上报结束时间
     */
    @ApiModelProperty(value="上报结束时间")
    @TableField("report_stop_time")
    private LocalDateTime reportStopTime;

    /**
     * 批次状态：  0: 上报中  1: 采购中  2: 已结束
     */
    @ApiModelProperty(value="批次状态：  0: 上报中  1: 采购中  2: 已结束")
    @TableField("bath_status")
    private Integer bathStatus;

    /**
     * 组织机构id
     */
    @ApiModelProperty(value="组织机构id")
    @TableField("org_id")
    private Integer orgId;

    /**
     * 统计的所有需求列表
     */
    @TableField(exist = false)
    private Collection<Demand> demandList;

    private static final long serialVersionUID = 1L;
}
