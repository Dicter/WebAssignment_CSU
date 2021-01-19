package com.tom.servlet;

import com.google.gson.Gson;
import com.tom.pojo.message;
import com.tom.pojo.user;
import com.tom.service.impl.userServiceImpl;
import com.tom.service.userService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class forgetServlet extends HttpServlet {

    private final userService userService=new userServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String SMSCode=req.getParameter("SMSCode");
        String password=req.getParameter("password");
        String phoneNumber=req.getParameter("phoneNumber");

        if(SMSCode==null){
            message message = new message("NO INPUT CODE");
            Gson gson = new Gson();
            String json = gson.toJson(message);
            System.out.println(json);
            resp.getWriter().write(json);
            return;
        }
        boolean result=userService.checkPhoneNumberUsage(phoneNumber);
        if(!result){
            message message = new message("WRONG PHONE NUMBER");
            Gson gson = new Gson();
            String json = gson.toJson(message);
            System.out.println(json);
            resp.getWriter().write(json);
        }else{
            HttpSession session=req.getSession();
            if(session.getAttribute("SMSCode")!=null) {
                if(SMSCode.equalsIgnoreCase((String) session.getAttribute("SMSCode"))) {
                    user user = userService.getUserByPhoneNumber(phoneNumber);
                    String username = user.getUsername();
                    int results = userService.updateUser(username, password, phoneNumber);
                    if (results == 1) {
                        message message = new message("MODIFIED");
                        Gson gson = new Gson();
                        String json = gson.toJson(message);
                        System.out.println(json);
                        resp.getWriter().write(json);
                    } else {
                        message message = new message("WRONG PHONE NUMBER");
                        Gson gson = new Gson();
                        String json = gson.toJson(message);
                        System.out.println(json);
                        resp.getWriter().write(json);
                    }
                } else {
                    message message = new message("WRONG CODE");
                    Gson gson = new Gson();
                    String json = gson.toJson(message);
                    System.out.println(json);
                    resp.getWriter().write(json);
                }
            }else{
                message message = new message("NO INPUT CODE");
                Gson gson = new Gson();
                String json = gson.toJson(message);
                System.out.println(json);
                resp.getWriter().write(json);
                return;
            }
        }
    }
}
