package com.bciit.project.ChatBook.controllers;

import com.bciit.project.ChatBook.entities.User;
import com.bciit.project.ChatBook.enums.PostType;
import com.bciit.project.ChatBook.enums.Visibility;
import com.bciit.project.ChatBook.services.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired
    PostService postService;

    @Autowired
    HttpSession session;

    @ResponseBody
    @PostMapping("/text/save")
    public Boolean saveTextPost(@RequestParam("post") String post, @RequestParam("visibility") Visibility visibility) {
        System.out.println("inside text controller: "+visibility);
        return postService.saveTextPost(post, visibility);
    }

    @ResponseBody
    @PostMapping("/image/save")
    public Boolean saveImagePost(@RequestParam("image-file") MultipartFile image, @RequestParam("image-visibility") Visibility visibility, @RequestParam("image-post") String description){
        System.out.println("inside controller image/save");

        return postService.savePost(image, visibility, description, PostType.IMAGE);
    }

    @ResponseBody
    @PostMapping("/video/save")
    public Boolean saveVideoPost(@RequestParam("video-file") MultipartFile video, @RequestParam("video-visibility") Visibility visibility, @RequestParam("video-post") String description){
        System.out.println("inside controller video/save");

        return postService.savePost(video, visibility, description, PostType.VIDEO);
    }

    @ResponseBody
    @PostMapping("/document/save")
    public Boolean saveDocumentPost(@RequestParam("doc-file") MultipartFile doc, @RequestParam("doc-visibility") Visibility visibility, @RequestParam("doc-post") String description){
        System.out.println("inside controller doc/save");

        return postService.savePost(doc, visibility, description, PostType.DOCUMENT);
    }

    @ResponseBody
    @DeleteMapping("/delete")
    public boolean deletePost(@RequestParam("id") String id){
        return postService.deletePost(id);
    }

    /*public void getAllPosts(){
        session.setAttribute("posts",postService.getAllPosts() );
    }*/

}