package com.tom.service;

import com.tom.pojo.user;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface userService {

    public void registerUser(user user);

    public user login(user user,String method);

    public boolean checkUsernameUsage(String username);

    public boolean checkPhoneNumberUsage(String phoneNumber);

    public List<user> getUserList();

    public int deleteUser(String username);

    public int updateUser(String modiUsername,String newPassword,String newPhoneNumber);

    public String sendMessage(String phoneNumber , HttpSession session);

    public user getUserByPhoneNumber(String phoneNumber);

    public user getUserByUsername(String username);
}
