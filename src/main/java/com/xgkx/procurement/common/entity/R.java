package com.xgkx.procurement.common.entity;

import com.alibaba.fastjson.JSON;
import com.xgkx.procurement.util.DateTimeUtils;
import org.springframework.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

/**
 * 统一返回实体
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename R
 * @date 2021/4/25 15:32
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public class R extends HashMap<String, Object> {

    private static Integer SUCCESS = HttpStatus.OK.value();
    private static Integer ERROR = HttpStatus.INTERNAL_SERVER_ERROR.value();

    public R() {
        put("status", SUCCESS);
        put("msg", "success");
        put("timestamp", DateTimeUtils.getCurrentDateTimeStr());
    }

    public static R error(int status, String msg) {
        R r = new R();
        r.put("status", status);
        r.put("msg", msg);
        return r;
    }

    public static R error() {
        return error(ERROR, "内部服务器错误，执行失败");
    }

    public static R error(String msg) {
        return error(ERROR, msg);
    }



    public static R error(int status, String msg, String path) {
        R r = new R();
        r.put("status", status);
        r.put("msg", msg);
        r.put("path", path);
        return r;
    }

    public static R ok(String msg) {
        R r = new R();
        r.put("msg", msg);
        return r;
    }

    public static R ok(String msg, Object data) {
        R r = new R();
        r.put("msg", msg);
        r.put("data", data);
        return r;
    }

    public static R ok(Map<String, Object> map) {
        R r = new R();
        r.putAll(map);
        return r;
    }

    public static R ok() {
        return new R();
    }

    public String toJSONString() {
        return JSON.toJSONString(this);
    }

    @Override
    public R put(String key, Object value) {
        super.put(key, value);
        return this;
    }

    public int getStauts() {
        return (int) super.get("status");
    }

    public String getMsg() {
        return (String) super.get("msg");
    }

}
