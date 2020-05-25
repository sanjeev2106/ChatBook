package com.bciit.project.ChatBook.services;

import com.bciit.project.ChatBook.entities.Post;
import com.bciit.project.ChatBook.entities.User;
import com.bciit.project.ChatBook.enums.PostType;
import com.bciit.project.ChatBook.enums.Visibility;
import com.bciit.project.ChatBook.repositories.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Service
public class PostService {

    @Autowired
    PostRepository postRepository;

    @Autowired
    HttpSession session;

    @Autowired
    Environment env;

    public Boolean saveTextPost(String post, Visibility visibility) {
        Post newPost = new Post();
        newPost.setDescription(post);
        newPost.setShareBy((User) session.getAttribute("user"));
        newPost.setType(PostType.ARTICLE);
        newPost.setDate(new Date());
        newPost.setDeleted(false);
        newPost.setVisibility(visibility);
        if(postRepository.save(newPost) != null){
            session.setAttribute("posts", getAllPosts());
            return true;
        }
        return false;
    }

    public Boolean savePost(MultipartFile file, Visibility visibility, String description, PostType type) {

        String directoryName = "posts/";
        String UPLOAD_FILE = null;//System.getProperty("os.name").toLowerCase().contains("windows") ? env.getProperty("windows.post.images") : env.getProperty("other.post.images");


        if(type==PostType.IMAGE){
            directoryName = "posts/images/";
            UPLOAD_FILE = System.getProperty("os.name").toLowerCase().contains("windows") ? env.getProperty("windows.post.images") : env.getProperty("other.post.images");
        }else if(type==PostType.VIDEO){
            directoryName = "posts/videos/";
            UPLOAD_FILE = System.getProperty("os.name").toLowerCase().contains("windows") ? env.getProperty("windows.post.videos") : env.getProperty("other.post.videos");
        }else if(type==PostType.DOCUMENT){
            directoryName = "posts/documents/";
            UPLOAD_FILE = System.getProperty("os.name").toLowerCase().contains("windows") ? env.getProperty("windows.post.documents") : env.getProperty("other.post.documents");
        }

        Post newPost = new Post();
        String fileName= file.getOriginalFilename();
        String date = String.valueOf(new Timestamp(System.currentTimeMillis()).getTime());
        User user = (User) session.getAttribute("user");

        try {
            byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOAD_FILE + user.getUserName() + "_" + date + "_" + fileName);
            Files.write(path, bytes);
            newPost.setAttachment( directoryName + user.getUserName() + "_" + date + "_" + fileName);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        newPost.setVisibility(visibility);
        newPost.setDate(new Date());
        newPost.setType(type);
        newPost.setDeleted(false);
        newPost.setShareBy(user);
        newPost.setDescription(description);
        if(postRepository.save(newPost) != null){
            session.setAttribute("posts", getAllPosts());
            return true;
        }
        return false;
    }

    public List<Post> getAllPosts(){
        List<Post> posts = postRepository.findByDeletedOrderByDateDesc(false);
        System.out.println("----> "+posts);
        return posts;
    }

    public boolean deletePost(String id) {
        Post post = postRepository.findPostById(Integer.parseInt(id));
        post.setDeleted(true);
        if(postRepository.save(post) != null){
            session.setAttribute("posts", getAllPosts());
            return true;
        }
        return false;
    }
}
