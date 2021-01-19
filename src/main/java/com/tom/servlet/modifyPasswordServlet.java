package com.tom.servlet;

import com.google.gson.Gson;
import com.tom.pojo.message;
import com.tom.pojo.user;
import com.tom.service.impl.userServiceImpl;
import com.tom.service.userService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class modifyPasswordServlet extends HttpServlet {

    private final userService userService=new userServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userAccount= (String) req.getParameter("account");
        String rasPassword= (String) req.getParameter("rawPassword");
        String newPassword= (String) req.getParameter("password");

        user user=userService.getUserByUsername(userAccount);
        boolean accountUsage=userService.checkUsernameUsage(userAccount);
        if(accountUsage){
            if(!user.getPassword().equals(rasPassword)){
                message message = new message("WRONG PASSWORD");
                Gson gson = new Gson();
                String json = gson.toJson(message);
                System.out.println(json);
                resp.getWriter().write(json);
            }else{
                String phoneNumber=user.getPhoneNumber();
                int results = userService.updateUser(userAccount, newPassword, phoneNumber);
                if(results==1){
                    message message = new message("MODIFIED");
                    Gson gson = new Gson();
                    String json = gson.toJson(message);
                    System.out.println(json);
                    resp.getWriter().write(json);
                }
            }
        }else{
            message message = new message("NO SUCH ACCOUNT");
            Gson gson = new Gson();
            String json = gson.toJson(message);
            System.out.println(json);
            resp.getWriter().write(json);
        }
    }
}
