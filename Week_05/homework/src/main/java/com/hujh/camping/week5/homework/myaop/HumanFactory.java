package com.hujh.camping.week5.homework.myaop;

import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * 委托实例的代理类
 */
public class HumanFactory {

    private static Object getBean(Object obj, ProxyMethod proxyMethod) {
        return Proxy.newProxyInstance(
                obj.getClass().getClassLoader(),
                obj.getClass().getInterfaces(),
                new MyAOPHandler(obj, proxyMethod)
        );
    }



    @SuppressWarnings("unchecked")
    public static <T> T getHuman(Class<?> clz, ProxyMethod method) {
        Object obj = null;
        try {
            obj = getBean(clz.getDeclaredConstructor().newInstance(), method);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (T) obj;
    }

    public static void main(String[] args)  {
        Human student = HumanFactory.getHuman(Student.class, new MyProxyMethod());
        student.work();
        student.eat();
        student.sleep();

        System.out.println("验证结束");
    }
}
