package com.hujh.camping.week5.homework.bean;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SchoolConfiguration {

    @Bean
    public Teacher teacher(){
        return new Teacher();
    }
}
