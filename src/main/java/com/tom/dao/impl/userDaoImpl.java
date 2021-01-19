package com.tom.dao.impl;

import com.tom.dao.userDao;
import com.tom.pojo.user;

import java.util.List;

public class userDaoImpl extends baseDao implements userDao {


    @Override
    public user queryUserByUsername(String username) {
        String sql= "select username, password,phoneNumber from userinfor where username =?";
        return queryForOne(user.class,sql,username);
    }

    @Override
    public user queryUserByUsernameAndPassword(String username, String password) {
        String sql= "select username, password,phoneNumber from userinfor where username =? and password=?";
        return queryForOne(user.class,sql,username,password);
    }

    @Override
    public int saveUser(user user) {
        String sql = "insert into userinfor(username,password,phoneNumber) values (?,?,?)";
        return update(sql,user.getUsername(),user.getPassword(),user.getPhoneNumber());
    }

    @Override
    public user queryUserByPhoneNumber(String phoneNumber) {
        String sql="select username,password,phoneNumber from userinfor where phoneNumber=?";
        return queryForOne(user.class,sql,phoneNumber);
    }

    @Override
    public List<user> queryForUserList() {
        String sql="select * from userinfor";
        return queryForList(user.class,sql);
    }

    @Override
    public int deleteSingleUser(String username) {
        String sql="delete from userinfor where username=?";
        return update(sql,username);
    }

    @Override
    public int updateUser(String modiUsername, user user) {
        String sql="update userinfor set password=?,phoneNumber=? where username=?";
        return update(sql,user.getPassword(),user.getPhoneNumber(),modiUsername);
    }
}
