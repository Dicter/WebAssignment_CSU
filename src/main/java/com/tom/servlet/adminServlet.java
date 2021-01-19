package com.tom.servlet;

import com.google.gson.Gson;
import com.tom.pojo.message;
import com.tom.pojo.user;
import com.tom.service.impl.userServiceImpl;
import com.tom.service.userService;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class adminServlet extends HttpServlet {

    userService userService=new userServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String request=req.getParameter("request");
        if(request.equalsIgnoreCase("userList")){
            List<user> userList=userService.getUserList();
            Gson gson=new Gson();
            String json=gson.toJson(userList);
            System.out.println(json);
            resp.getWriter().write(json);
        }else if(request.equalsIgnoreCase("del")){
            String username=  req.getParameter("username");
            int result=userService.deleteUser(username);
            if(result==1){
                Gson gson=new Gson();
                message message=new message("SUCCESS");
                String json=gson.toJson(message);
                resp.getWriter().write(json);
                System.out.println("删除"+username+"用户成功");
            }
        }else if(request.equalsIgnoreCase("modi")){
            String username=req.getParameter("username");
            String newPassword=req.getParameter("newPassword");
            String newPhoneNumber=req.getParameter("newPhoneNumber");
            System.out.println(username+"\t"+newPassword+"\t"+newPhoneNumber);
            int result=userService.updateUser(username,newPassword,newPhoneNumber);
            if(result==1){
                Gson gson=new Gson();
                message message=new message("MODIFY SUCCESS");
                String json=gson.toJson(message);
                resp.getWriter().write(json);
                System.out.println("更改用户"+username+"的信息成功");

            }
        }else if(request.equalsIgnoreCase("append")){
            String newUsername=req.getParameter("username");
            String newPassword=req.getParameter("newPassword");
            String newPhoneNumber=req.getParameter("newPhoneNumber");
            if(userService.getUserByPhoneNumber(newPhoneNumber)!=null){
                Gson gson=new Gson();
                message message=new message("PHONE ALREADY EXISTED");
                String json=gson.toJson(message);
                resp.getWriter().write(json);
                System.out.println("新增用户"+newPhoneNumber+"失败：手机号已存在。");
            }else if(userService.checkUsernameUsage(newUsername)){
                Gson gson=new Gson();
                message message=new message("USERNAME ALREADY EXISTED");
                String json=gson.toJson(message);
                resp.getWriter().write(json);
                System.out.println("新增用户"+newUsername+"失败：用户已存在。");
            }else{
                userService.registerUser(new user(newUsername,newPhoneNumber,newPassword));
                Gson gson=new Gson();
                message message=new message("APPEND SUCCESS");
                String json=gson.toJson(message);
                resp.getWriter().write(json);
                System.out.println("新增用户"+newUsername+"成功。");
            }
        }else if(request.equalsIgnoreCase("check")){
            String username=req.getParameter("username");
            user user=userService.getUserByUsername(username);
            Gson gson=new Gson();
            if(user==null){
                message message=new message("NO SUCH USER");
                String json=gson.toJson(message);
                resp.getWriter().write(json);
                System.out.println("查询用户"+username+"失败，不存在该用户。");
            }else{
                String json=gson.toJson(user);
                resp.getWriter().write(json);
                System.out.println("查询用户"+username+"成功。");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws  IOException {
        doPost(req, resp);
    }
}
