package com.tom.filter;

import com.tom.pojo.user;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class loginSuccessFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpServletRequest=(HttpServletRequest) request;
        HttpServletResponse httpServletResponse=(HttpServletResponse) response;

        HttpSession httpSession=httpServletRequest.getSession();
        user user= (com.tom.pojo.user) httpSession.getAttribute("user");

        if(user==null){
            System.out.println("Request not allowed!");
            httpServletResponse.sendRedirect("index.jsp");
        }else{
            chain.doFilter(request,response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
