package com.bciit.project.ChatBook.repositories;

import com.bciit.project.ChatBook.entities.Post;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PostRepository extends CrudRepository<Post, Integer>{

    List<Post> findByDeletedOrderByDateDesc(boolean val);

    Post findPostById(Integer id);
}