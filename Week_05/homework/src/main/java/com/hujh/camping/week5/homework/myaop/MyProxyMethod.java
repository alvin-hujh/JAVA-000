package com.hujh.camping.week5.homework.myaop;

import java.lang.reflect.Method;

public class MyProxyMethod implements ProxyMethod {
    @Override
    public void before(Object proxy, Method method, Object[] args) {
        System.out.println("拦截方法成功，name="+method.getName());
        System.out.println("课前预习");
    }

    @Override
    public void after(Object proxy, Method method, Object[] args) {
        System.out.println("拦截方法成功，name="+method.getName());
        System.out.println("课后复习");
    }
}
