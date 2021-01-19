package com.tom.dao;

import com.tom.pojo.user;

import java.util.List;

public interface userDao {

    public user queryUserByUsername(String username);

    public user queryUserByUsernameAndPassword(String username,String password);

    public int saveUser(user user);

    public user queryUserByPhoneNumber(String phoneNumber);

    public List<user> queryForUserList();

    public int deleteSingleUser(String username);

    public int updateUser(String modiUsername, user user);

}
