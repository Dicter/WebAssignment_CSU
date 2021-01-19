package com.tom.test;

import com.tom.dao.impl.userDaoImpl;
import com.tom.dao.userDao;
import com.tom.pojo.user;
import org.junit.Test;

public class userDaoImplTest {

    @Test
    public void queryUserByUsername() {
        userDao userDao=new userDaoImpl();
        System.out.println(userDao.queryUserByUsername("8208180521"));
    }

    @Test
    public void queryUserByUsernameAndPassword() {
        userDao userDao=new userDaoImpl();
        System.out.println(userDao.queryUserByUsernameAndPassword("8208180521","Dashui506"));
    }

    @Test
    public void saveUser() {
        userDao userDao=new userDaoImpl();
        System.out.println(userDao.saveUser(new user("admin","admin","admin")));
    }

    @Test
    public void queryForUserList() {
        userDao userDao=new userDaoImpl();
        System.out.println(userDao.queryForUserList());
    }

    @Test
    public void deleteSingleUser(){
        userDao userDao=new userDaoImpl();
        System.out.println(userDao.deleteSingleUser("8208180501"));
        System.out.println(userDao.deleteSingleUser("8208180521"));
    }

    @Test
    public void upDateUser(){
        userDao userDao=new userDaoImpl();
        System.out.println(userDao.updateUser("8208180521",new user("8208180521","Dashui0506","19977781898")));
    }
}