package com.hujh.camping.week5.homework.bean;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class Teacher {
    private String name;

    public void teach(){
        System.out.println("同学们，开始上课了");
    }
}
