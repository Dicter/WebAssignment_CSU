package com.tom.servlet;

import com.google.gson.Gson;
import com.tom.pojo.message;
import com.tom.service.impl.userServiceImpl;
import com.tom.service.userService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class messageServlet extends HttpServlet {
    userService userService=new userServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String phone =  req.getParameter("phone");
        System.out.println("申请短信验证码的号码："+phone);
        if(!userService.checkPhoneNumberUsage(phone)){
            System.out.println("无效的手机号");
            message message=new message("NO SUCH PHONE");
            Gson gson=new Gson();
            String json=gson.toJson(message);
            System.out.println(json);
            resp.getWriter().write(json);
            return;
        }
        HttpSession session=req.getSession();
        String messages = userService.sendMessage(phone,session);
        Cookie cookie = new Cookie(phone, messages);
        cookie.setMaxAge(60*5);
        resp.addCookie(cookie);
        System.out.println("有效的手机号");
        message message=new message("SENT");
        Gson gson=new Gson();
        String json=gson.toJson(message);
        System.out.println(json);
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
