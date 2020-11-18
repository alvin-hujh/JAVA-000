package com.hujh.camping.week5.homework.myaop;

import com.hujh.camping.week5.homework.myaop.target.MyAOP;

import java.lang.reflect.Method;

public class AnnoInjection {
    public static Object getBean(Object obj) {
        try {
            Method m[] = obj.getClass().getDeclaredMethods();
            for (Method method : m) {
                MyAOP myAOP = method.getAnnotation(MyAOP.class);
                if (myAOP != null) {
                    method.invoke(obj);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  obj;
    }

}
