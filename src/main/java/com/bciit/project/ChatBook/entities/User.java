package com.bciit.project.ChatBook.entities;

import com.bciit.project.ChatBook.enums.Gender;
import com.bciit.project.ChatBook.enums.Visibility;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

import javax.persistence.*;
import java.util.*;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String firstName;
    private String lastName;
    @Transient
    private String fullName;
    private Gender gender;
    @Column(unique = true)
    private String email;
    @Column(unique = true)
    private String userName;
    private String password;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(value = TemporalType.DATE)
    private Date dob;
    private Integer startSession;
    private Integer endSession;
    @Temporal(value = TemporalType.DATE)
    private Date createdOn;
    @Temporal(value = TemporalType.DATE)
    private Date updatedOn;
    private String photo;
    private Long number;
    private Boolean active;
    private Boolean admin;
    @OneToMany(mappedBy = "shareBy")
    private List<Post> posts;
    @ManyToMany(mappedBy = "likeBy")
    private List<Post> postLikes;
    @Enumerated(EnumType.STRING)
    private Visibility visibility;

    @OneToMany(mappedBy = "followBy", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Collection<Follow> followers = new HashSet<>();
    @OneToMany(mappedBy = "followTo", cascade = CascadeType.ALL)
    private Collection<Follow> follows = new HashSet<>();

    @Transient
    private String session;
    private boolean deleted;

    public boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Integer getStartSession() {
        return startSession;
    }

    public void setStartSession(Integer startSession) {
        this.startSession = startSession;
    }

    public Integer getEndSession() {
        return endSession;
    }

    public void setEndSession(Integer endSession) {
        this.endSession = endSession;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Date getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(Date updatedOn) {
        this.updatedOn = updatedOn;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Long getNumber() {
        return number;
    }

    public void setNumber(Long number) {
        this.number = number;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Boolean getAdmin() {
        return admin;
    }

    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }

    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }

    public List<Post> getPostLikes() {
        return postLikes;
    }

    public void setPostLikes(List<Post> postLikes) {
        this.postLikes = postLikes;
    }

    public Visibility getVisibility() {
        return visibility;
    }

    public void setVisibility(Visibility visibility) {
        this.visibility = visibility;
    }

    public String getFullName() {
        return firstName+" "+lastName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getSession() {
        return startSession+"-"+endSession;
    }

    public Collection<Follow> getFollowers() {
        return followers;
    }

    public void setFollowers(Collection<Follow> followers) {
        this.followers = followers;
    }

    public Collection<Follow> getFollows() {
        return follows;
    }

    public void setFollows(Collection<Follow> follows) {
        this.follows = follows;
    }

    public void setSession(String session) {
        this.session = session;
    }

    public boolean isDeleted() {
        return deleted;
    }
}
