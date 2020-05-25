package com.bciit.project.ChatBook.repositories;

import com.bciit.project.ChatBook.entities.Follow;
import com.bciit.project.ChatBook.entities.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {

    User findByUserNameAndPassword(String userName, String password);

    User findByUserName(String name);
    User findByEmail(String email);

    User findByEmailOrUserName(String email, String name);
    List<User> findAllByOrderByCreatedOnDesc();
    //List<User> findByFollowersNotInOrderByCreatedOnDesc(List<Follow> follows);
    //List<User> findAllFollowersByUser(Integer id);


    User findUserById(Integer id);

    @Query("SELECT CONCAT(u.firstName, ' ', u.lastName) FROM User u WHERE u.firstName LIKE CONCAT('%',:name,'%') OR u.lastName LIKE CONCAT('%',:name,'%')")
    List<String> findUsersWithPartOfName(@Param("name") String name);
}
