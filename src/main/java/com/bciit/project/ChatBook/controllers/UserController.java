package com.bciit.project.ChatBook.controllers;

import com.bciit.project.ChatBook.entities.User;
import com.bciit.project.ChatBook.repositories.UserRepository;
import com.bciit.project.ChatBook.services.FollowService;
import com.bciit.project.ChatBook.services.PostService;
import com.bciit.project.ChatBook.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Base64;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    UserRepository userRepository;

    @Autowired
    HttpSession session;

    @Autowired
    PostService postService;

    @Autowired
    FollowService followService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/home")
    public String home() {
        session.setAttribute("posts",postService.getAllPosts() );
        session.setAttribute("followerList", getMaxFollowerUser());
        session.setAttribute("followers", getFollowerCount());
        session.setAttribute("follows", getFollowCount());
        return "home";
    }

   /* @GetMapping("/login")
    public String bachToIndex() {
        return "index";
    }*/

    /**
     * User Registration api
     * @param user
     * @param pic
     * @param response
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    @PostMapping("/register")
    public void userRegister(@ModelAttribute("user") User user, @RequestParam("pic") MultipartFile pic, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
        System.out.println("before");

        User user1 = userService.resisterUser(user, pic);
        //System.out.println("-------");
        session.setAttribute("user", user1);
        response.sendRedirect("/home");
    }

    @PostMapping("/login")
    public void userLogin(@RequestParam("userName") String userName, @RequestParam("password") String password, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = userService.loginUser(userName, password);
        if (user != null && user.getActive()) {
            session.setAttribute("user", user);
            response.sendRedirect("/home");
        } else {
            request.setAttribute("message", "Invalid Credentials");
            request.getRequestDispatcher("/").forward(request, response);
        }
    }

    @GetMapping("/logout")
    public void logout(HttpServletResponse response) throws IOException {
        session.removeAttribute("user");
        session.invalidate();
        response.sendRedirect("/");
    }

    @GetMapping("/checkUserNameAvailability")
    @ResponseBody
    public User getUserByUserName(@RequestParam("userName") String userName) {
        return userService.getUserByUserName(userName);
    }

    @GetMapping("/checkEmailAvailability")
    @ResponseBody
    public User getUserByEmail(@RequestParam("email") String email) {
        return userService.getUserByEmail(email);
    }

    @PostMapping("/forgotPassword")
    @ResponseBody
    public String forgotPassword(@RequestParam("forgotId") String userName) throws MessagingException, ServletException, IOException {
        String id = userService.getUserByEmailOrUserName(userName);
        session.setAttribute("forgetUserId", id);
        String forgotMessage = "Sorry! You are not registered with us, Please create your account first.";
        if (id != null) {
            forgotMessage = "Please enter the OTP send to your registered email Id: " + id;
        }
        return forgotMessage;
    }

    @PostMapping("/validateOTP")
    @ResponseBody
    public Boolean validateOTP(@RequestParam("otp") String otp) {
        return otp.equals(session.getAttribute("sendOTP").toString());
    }

    @PostMapping("/changePassword")
    @ResponseBody
    public Boolean changePassword(@RequestParam("changePassword") String password) {
        User user = userRepository.findByEmail(session.getAttribute("forgetUserId").toString());
        session.removeAttribute("forgetUserId");
        session.removeAttribute("sendOTP");
        user.setPassword(Base64.getEncoder().encodeToString(password.getBytes()));
        return userRepository.save(user) != null;
    }

    private List<User> getMaxFollowerUser(){
        return userService.getMaxFollowerUser();

    }

    private int getFollowerCount(){
        User user = (User)session.getAttribute("user");
        return followService.getCountByFollowers(user);
    }

    private int getFollowCount(){
        User user = (User)session.getAttribute("user");
        return followService.getCountByFollow(user);
    }

    @GetMapping("/search")
    @ResponseBody
    public List<String> searchUser(@RequestParam("name") String name){
        return userService.searchUser(name);
    }
}
