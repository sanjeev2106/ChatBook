package com.bciit.project.ChatBook.services;

import com.bciit.project.ChatBook.entities.Follow;
import com.bciit.project.ChatBook.entities.User;
import com.bciit.project.ChatBook.enums.Visibility;
import com.bciit.project.ChatBook.repositories.FollowRepository;
import com.bciit.project.ChatBook.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import static java.util.stream.Collectors.toList;

@Service
public class UserService {

    @Autowired
    UserRepository userRepository;

    @Autowired
    FollowRepository followRepository;

    @Autowired
    HttpSession httpSession;

    @Autowired
    private Environment env;


    public User resisterUser(User user, MultipartFile file) {
        System.out.println("in service");
        final String UPLOAD_FILE = System.getProperty("os.name").toLowerCase().contains("windows") ? env.getProperty("windows.os.path") : env.getProperty("other.os.path");
        user.setAdmin(false);
        user.setActive(true);
        user.setDeleted(false);
        user.setCreatedOn(new Date());
        user.setUpdatedOn(new Date());
        user.setVisibility(Visibility.PUBLIC);

        if (file.isEmpty()) {
            user.setPhoto("images/default-user-image.png");
        } else {
            try {
                byte[] bytes = file.getBytes();
                Path path = Paths.get(UPLOAD_FILE + user.getUserName() + "_" + file.getOriginalFilename());
                Files.write(path, bytes);
                user.setPhoto("profiles/" + user.getUserName() + "_" + file.getOriginalFilename());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        String password = user.getPassword();
        String encryptedPassword = Base64.getEncoder().encodeToString(password.getBytes());
        user.setPassword(encryptedPassword);

        userRepository.save(user);
        return user;
    }

    public User loginUser(String userName, String password) {
        String encryptedPassword = Base64.getEncoder().encodeToString(password.getBytes());
        return userRepository.findByUserNameAndPassword(userName, encryptedPassword);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User getUserByUserName(String userName) {
        return userRepository.findByUserName(userName);
    }

    public String getUserByEmailOrUserName(String UserName) throws MessagingException {
        String registeredId = null;
        User user = userRepository.findByEmailOrUserName(UserName, UserName);
        if (user != null) {
            registeredId = user.getEmail();
            emailService(user.getEmail(), user.getFirstName());
        }
        return registeredId;
    }

    private void emailService(String email, String name) throws MessagingException {
        Random random = new Random();
        int OTP = 100000 + random.nextInt(20000);

        final String senderId = "chatbook.bciit@gmail.com";
        final String senderPassword = "ChatBook@bciit";
        final String subject = "Forgot Password Reset OTP";
        //String body ;//= "Your Email Id :" + email + " And OTP is : " + OTP;
        String body = "<div class=\"card bg-secondary mb-3\" style=\"max-width: 20rem;\">\n" +
                "  <div class=\"card-header\"><h4>Hi " + name + ",</h4></div>\n" +
                "  <div class=\"card-body\">\n" +
                "    <p class=\"card-text\">You recently requested to reset your password for your ChatBook account. " +
                "Please use below OTP to reset it.</p><h4>" + OTP + "</h4>\n" +
                "<p class=\"card-text\">If you did not request a password reset, please ignore this email.</p><br/><h5>Thanks,<br/>ChatBook Team</h5>  </div>\n" +
                "</div>";

        httpSession.setAttribute("sendOTP", OTP);

        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.auth", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderId, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderId));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
            message.setSubject(subject);
            message.setContent(body, "text/html;     charset=utf-8");
            Transport.send(message);
        } catch (MessagingException
                messageException) {
            throw new RuntimeException(messageException);
        }
    }

    public List<User> getMaxFollowerUser() {

        User loggedInUser = (User) httpSession.getAttribute("user");
        User user = userRepository.findUserById(loggedInUser.getId());
        Collection<Follow> follows = user.getFollowers();
        List<User> users = userRepository.findAllByOrderByCreatedOnDesc();

        List<User> userList = new ArrayList<>();
        List<User> followToList = follows.stream()
                .map(Follow::getFollowTo).collect(toList());
        List<Integer> ids = followToList.stream().map(User::getId).collect(toList());

        for (User u : users) {
            if (!ids.contains(u.getId()) && !u.getId().equals(loggedInUser.getId())) {
                userList.add(u);
            }
        }
        return userList;
    }

    public List<String> searchUser(String name) {
        return userRepository.findUsersWithPartOfName(name);
    }

}
