package com.xgkx.procurement.exception;

import lombok.Data;

/**
 * 业务逻辑异常
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename BussinessException
 * @date 2021/5/3 11:11
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Data
public class BussinessException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    /**
     * 错误信息
     **/
    private String msg;

    public BussinessException(String msg) {
        this.msg = msg;
    }
}
