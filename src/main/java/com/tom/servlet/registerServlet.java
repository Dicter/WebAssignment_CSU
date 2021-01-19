package com.tom.servlet;

import com.google.gson.Gson;
import com.tom.pojo.message;
import com.tom.pojo.user;
import com.tom.service.impl.userServiceImpl;
import com.tom.service.userService;

import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class registerServlet extends HttpServlet {


    private userService userService=new userServiceImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //super.doPost(req, resp);

        String username=req.getParameter("username");
        String password=req.getParameter("password");
        String phoneNumber=req.getParameter("phoneNumber");

            if(userService.checkUsernameUsage(username)){
                System.out.println("用户名已被占用");
                message message=new message("DUPLICATED ACCOUNT");
                Gson gson=new Gson();
                String json=gson.toJson(message);
                System.out.println(json);
                resp.getWriter().write(json);
            }else{
                if(userService.checkPhoneNumberUsage(phoneNumber)){
                    System.out.println("手机号已被占用");
                    message message=new message("DUPLICATED PHONE");
                    Gson gson=new Gson();
                    String json=gson.toJson(message);
                    System.out.println(json);
                    resp.getWriter().write(json);
                }else{
                    userService.registerUser(new user(username,phoneNumber,password));
                    System.out.println("注册成功");
                    message message=new message("SIGNIN SUCCESS");
                    Gson gson=new Gson();
                    String json=gson.toJson(message);
                    System.out.println(json);
                    resp.getWriter().write(json);
                }
            }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
