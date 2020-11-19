package com.hujh.camping.week5.homework.myaop;

import com.hujh.camping.week5.homework.myaop.target.MyAOP;

public class Student implements Human {
    @Override
    public void eat() {
        System.out.println("吃食堂");
    }


    public void sleep() {
        System.out.println("睡宿舍");
    }

    @MyAOP
    @Override
    public void work() {
        System.out.println("好好学习");
    }
}
