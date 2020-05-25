package com.bciit.project.ChatBook.controllers;

import com.bciit.project.ChatBook.entities.User;
import com.bciit.project.ChatBook.services.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class FollowController {

    @Autowired
    FollowService followService;

    @Autowired
    HttpSession session;

    @GetMapping("/follows/{id}")
    public void addFollows(@PathVariable("id") Integer id, HttpServletResponse response){
        User loggedInUser = (User) session.getAttribute("user");
        followService.addFollows(id, loggedInUser);
        try {
            response.sendRedirect("/home");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
