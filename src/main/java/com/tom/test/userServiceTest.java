package com.tom.test;

import com.tom.pojo.user;
import com.tom.service.impl.userServiceImpl;
import com.tom.service.userService;
import org.junit.Test;

public class userServiceTest {

    userService userService=new userServiceImpl();

    @Test
    public void registerUser() {
        userService.registerUser(new user("8208180500","15367884231","Dashui506"));
    }

    @Test
    public void login() {
        System.out.println(userService.login(new user("8208180500","15367884231","Dashui506"),"PASSWORD"));
        System.out.println(userService.login(new user("admin","admin","123456"),"SMS"));
    }

    @Test
    public void checkUsernameUsage() {
        System.out.println(userService.checkUsernameUsage("admin"));
        System.out.println(userService.checkUsernameUsage("DAO"));
    }

    @Test
    public void checkPhoneNumberUsage(){
        System.out.println(userService.checkPhoneNumberUsage("17877781898"));
        System.out.println(userService.checkPhoneNumberUsage("155555555"));
    }
}