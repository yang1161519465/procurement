package com.xgkx.procurement.handler;

import com.xgkx.procurement.common.entity.R;
import com.xgkx.procurement.exception.BussinessException;
import com.xgkx.procurement.util.ServletUtils;
import org.springframework.http.HttpStatus;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

/**
 * 全局异常处理
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename GlobalExceptionHandler
 * @date 2021/5/3 11:05
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@ControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 方法不支持异常处理
     *
     * @author 杨旭晨
     * @date 11:10 2021/5/3
     * @param e:
     * @return com.xgkx.procurement.common.entity.R
     **/
    @ExceptionHandler({HttpRequestMethodNotSupportedException.class})
    public void HttpRequestMethodNotSupportedExceptionHandler(HttpServletRequest request,
                                                              HttpServletResponse response,
                                                              HttpRequestMethodNotSupportedException e) {
        e.printStackTrace();
        ServletUtils.renderString(response, R.error(HttpStatus.METHOD_NOT_ALLOWED.value(),
                "本接口：" + ServletUtils.getRequest().getRequestURI() +
                "；不支持" + e.getMethod()).toJSONString());
    }

    @ExceptionHandler({SQLException.class})
    public void  SQLExceptionHandler(HttpServletRequest request,
                                     HttpServletResponse response,
                                     SQLException e) {
        e.printStackTrace();
        ServletUtils.renderString(response, R.error("sql语句异常" + e.getMessage()).toJSONString());
    }

    /**
     * 处理业务逻辑异常
     *
     * @author 杨旭晨
     * @date 11:14 2021/5/3
     * @param e:
     * @return com.xgkx.procurement.common.entity.R
     **/
    @ExceptionHandler({BussinessException.class})
    public void BussinessExceptionHandler(HttpServletRequest request,
                                       HttpServletResponse response,
                                          BussinessException e) {
        e.printStackTrace();
        ServletUtils.renderString(response, R.error(e.getMsg()).toJSONString());
    }

    /**
     * 处理其他异常
     * @param req
     * @param e
     * @return
     */
    @ExceptionHandler(value =Exception.class)
    public void exceptionHandler(HttpServletRequest request,
                                 HttpServletResponse response, Exception e){
        e.printStackTrace();
        ServletUtils.renderString(response, R.error(HttpStatus.INTERNAL_SERVER_ERROR.value(),
                "未知错误" + e.getMessage()).toJSONString());
    }

}
