package com.hujh.camping.week5.homework.myaop;

import com.hujh.camping.week5.homework.myaop.target.MyAOP;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class MyAOPHandler implements InvocationHandler {
    //目标代理对象
    private Object target;
    //处理方法
    private ProxyMethod proxyMethod;

    public MyAOPHandler(Object human, ProxyMethod method) {
        this.target = human;
        this.proxyMethod = method;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        Object result;
        if (getFlag(target, method)) {
            this.proxyMethod.before(proxy, method, args);
            result = method.invoke(target, args);
            this.proxyMethod.after(proxy, method, args);
        } else {
            System.out.println("未拦截的方法，name = " + method.getName());
            result = method.invoke(target, args);
        }
        return result;
    }

    private Boolean getFlag(Object obj, Method method) {
        boolean flag = false;
        try {
            Method[] declaredMethods = obj.getClass().getDeclaredMethods();
            for (Method dm : declaredMethods) {
                MyAOP myAOP = dm.getAnnotation(MyAOP.class);
                if (myAOP != null && dm.getName().equalsIgnoreCase(method.getName())) {
                    flag = true;
                    break;
                }
            }
        } catch (Exception e) {
            System.out.println("获取注解方法失败");
        }
        return flag;
    }

}
