package com.bciit.project.ChatBook.repositories;

import com.bciit.project.ChatBook.entities.Follow;
import com.bciit.project.ChatBook.entities.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface FollowRepository extends CrudRepository<Follow, Integer> {

    int countAllByFollowBy(User user);

    int countAllByFollowTo(User user);

}
