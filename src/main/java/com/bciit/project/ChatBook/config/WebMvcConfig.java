package com.bciit.project.ChatBook.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

    @Autowired
    Interceptor myInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        List<String> excludeURLs = new ArrayList<>();
        excludeURLs.add("/");
        excludeURLs.add("/login");
        excludeURLs.add("/register");
        excludeURLs.add("/checkUserNameAvailability");
        excludeURLs.add("/checkEmailAvailability");
        excludeURLs.add("/forgotPassword");
        excludeURLs.add("/validateOTP");
        excludeURLs.add("/changePassword");
        excludeURLs.add("/css/**");
        excludeURLs.add("/js/**");
        excludeURLs.add("/profiles/**");
        excludeURLs.add("/images/**");

        registry.addInterceptor(myInterceptor).excludePathPatterns(excludeURLs);
    }
}

