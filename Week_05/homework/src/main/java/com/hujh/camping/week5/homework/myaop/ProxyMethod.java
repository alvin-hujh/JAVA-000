package com.hujh.camping.week5.homework.myaop;

import java.lang.reflect.Method;

/**
 * 定义代理类接口
 */
public interface ProxyMethod {
    /**
     * 拦截前执行方法
     */
    void before(Object proxy, Method method, Object[] args);

    /**
     * 拦截后执行方法
     */
    void after(Object proxy, Method method, Object[] args);
}
