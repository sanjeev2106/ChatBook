package com.bciit.project.ChatBook.config;

import com.bciit.project.ChatBook.entities.User;
import com.bciit.project.ChatBook.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class Interceptor extends HandlerInterceptorAdapter {

    @Autowired
    UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("interceptor url : " + request.getRequestURI());
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            User user1 = userService.getUserByEmail(user.getEmail());
            if (!user1.getActive()) {
                session.invalidate();
                response.sendRedirect("/");
                return false;
            }
        }

        if(session.getAttribute("user") == null){
            response.sendRedirect("/");
            return false;
        }
        return true;
    }
}