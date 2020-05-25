package com.bciit.project.ChatBook.services;

import com.bciit.project.ChatBook.entities.Follow;
import com.bciit.project.ChatBook.entities.User;
import com.bciit.project.ChatBook.repositories.FollowRepository;
import com.bciit.project.ChatBook.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FollowService {

    @Autowired
    FollowRepository followRepository;

    @Autowired
    UserRepository userRepository;

    public void addFollows(Integer id, User loggedInUser) {
        User user = userRepository.findUserById(id);
        Follow follow = new Follow();
        follow.setFollowTo(user);
        follow.setFollowBy(loggedInUser);
        followRepository.save(follow);
/*
        Follower follower = new Follower();
        follower.setUser(loggedInUser);
        followerRepository.save(follower);*/
    }

    public int getCountByFollow(User user) {
        return followRepository.countAllByFollowTo(user);
    }

    public int getCountByFollowers(User user) {
        return followRepository.countAllByFollowBy(user);
    }
}
