package com.hujh.camping.week5.homework.myaop;

import com.hujh.camping.week5.homework.myaop.target.MyAOP;

public class Student implements Human {
    @Override
    public String eat() {
        return "吃食堂";
    }


    public String sleep() {
        return "睡宿舍";
    }

    @MyAOP
    @Override
    public String work() {
        return "好好学习";
    }
}
