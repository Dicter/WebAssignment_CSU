package com.tom.service.impl;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.tom.dao.impl.userDaoImpl;
import com.tom.dao.userDao;
import com.tom.pojo.user;
import com.tom.service.userService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Random;

public class userServiceImpl implements userService {


    private userDao userDao=new userDaoImpl();

    @Override
    public void registerUser(user user) {
        userDao.saveUser(user);
    }

    @Override
    public user login(user user,String method) {
        if(method.equalsIgnoreCase("SMS")){
            return userDao.queryUserByPhoneNumber(user.getPhoneNumber());
        }else{
            return userDao.queryUserByUsernameAndPassword(user.getUsername(),user.getPassword());
        }
    }

    @Override
    public boolean checkUsernameUsage(String username) {
        return userDao.queryUserByUsername(username) != null;
    }

    @Override
    public boolean checkPhoneNumberUsage(String phoneNumber) {
        return userDao.queryUserByPhoneNumber(phoneNumber)!=null;
    }

    @Override
    public List<user> getUserList() {
        return userDao.queryForUserList();
    }

    @Override
    public int deleteUser(String username) {
        return userDao.deleteSingleUser(username);
    }

    @Override
    public int updateUser(String modiUsername, String newPassword, String newPhoneNumber) {
        return userDao.updateUser(modiUsername,new user(modiUsername,newPhoneNumber,newPassword));
    }

    @Override
    public String sendMessage(String phone, HttpSession session) {
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou",
                "LTAI4GGvqPXnjegKTJacdrYr",
                "3GC8UBpLqFxL98KQhQTrebCwg3VQ4I");
        IAcsClient client = new DefaultAcsClient(profile);
        CommonRequest request = new CommonRequest();
        request.setSysMethod(MethodType.POST);
        request.setSysDomain("dysmsapi.aliyuncs.com");
        request.setSysVersion("2017-05-25");
        request.setSysAction("SendSms");
        request.putQueryParameter("PhoneNumbers", phone);
        request.putQueryParameter("SignName", "ABC商城");
        request.putQueryParameter("TemplateCode", "SMS_206735076");
        String str=String.format("%04d",new Random().nextInt(8999) + 1000);
        request.putQueryParameter("TemplateParam", "{\"code\": "+str+"}");
        session.setAttribute("SMSCode",str);
        System.out.println(phone+":"+str);
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ClientException e) {
            e.printStackTrace();
        }
        return str;
    }

    @Override
    public user getUserByPhoneNumber(String phoneNumber) {
        return userDao.queryUserByPhoneNumber(phoneNumber);
    }

    @Override
    public user getUserByUsername(String username) {
        return userDao.queryUserByUsername(username);
    }
}
