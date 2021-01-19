package com.tom.servlet;

import com.google.gson.Gson;
import com.tom.pojo.message;
import com.tom.pojo.user;
import com.tom.service.impl.userServiceImpl;
import com.tom.service.userService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class loginServlet extends HttpServlet {

    private final userService userService=new userServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username=req.getParameter("username");
        String password=req.getParameter("password");
        String phoneNumber=req.getParameter("phoneNumber");
        String SMSCode=req.getParameter("SMSCode");
        String code=req.getParameter("code");
        String token= (String) req.getSession().getAttribute("KAPTCHA_SESSION_KEY");
        req.getSession().removeAttribute("KAPTCHA_SESSION_KEY");
        if((token==null || !code.equalsIgnoreCase(token))&&SMSCode==null){
            System.out.println("验证码错误或无效");
            message message=new message("WRONG CODE");
            Gson gson=new Gson();
            String json=gson.toJson(message);
            System.out.println(json);
            resp.getWriter().write(json);
            return;
        }
        if(phoneNumber==null){
            user result=userService.login(new user(username,password),"PASSWORD");
            if(result==null){
                System.out.println("无效的用户名或密码");
                message message=new message("USERNAME LOGIN ERROR");
                Gson gson=new Gson();
                String json=gson.toJson(message);
                System.out.println(json);
                resp.getWriter().write(json);
            }else{
                System.out.println("通过用户名+密码登录成功");
                message message=new message("USERNAME LOGIN SUCCESS");
                req.getSession().setAttribute("user",result);
                Gson gson=new Gson();
                String json=gson.toJson(message);
                System.out.println(json);
                resp.getWriter().write(json);
            }
        }else if(username==null){
            user result=userService.login(new user(phoneNumber),"SMS");
            if(result==null){
                System.out.println("无效的手机号");
                message message=new message("PHONE LOGIN ERROR");
                Gson gson=new Gson();
                String json=gson.toJson(message);
                System.out.println(json);
                resp.getWriter().write(json);
            }else{
                HttpSession session=req.getSession();
                if(session.getAttribute("SMSCode")!=null){
                    if(SMSCode.equalsIgnoreCase((String) session.getAttribute("SMSCode"))){
                        user user = userService.getUserByPhoneNumber(phoneNumber);
                        req.getSession().setAttribute("user", user);
                        System.out.println(user.toString());
                        message message = new message("PHONE LOGIN SUCCESS");
                        req.getSession().setAttribute("user",user);
                        Gson gson = new Gson();
                        String json = gson.toJson(message);
                        System.out.println(json);
                        resp.getWriter().write(json);
                    }else{
                        message message = new message("PHONE LOGIN ERROR");
                        Gson gson = new Gson();
                        String json = gson.toJson(message);
                        System.out.println(json);
                        resp.getWriter().write(json);
                    }
                }
            }
        }
    }
}
