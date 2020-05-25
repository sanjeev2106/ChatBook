package com.bciit.project.ChatBook.entities;

import com.bciit.project.ChatBook.enums.PostType;
import com.bciit.project.ChatBook.enums.Visibility;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class Post {
    @Id
    @GeneratedValue
    private Integer id;
    @Enumerated(EnumType.STRING)
    private PostType type;
    @ManyToOne
    private User shareBy;
    private Date date;
    private String attachment;
    private String description;
    @ManyToMany
    private List<User> likeBy = new ArrayList<>();
    @Embedded
    private List<Comment> comments;
    @Enumerated(EnumType.STRING)
    private Visibility visibility;
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

    public PostType getType() {
        return type;
    }

    public void setType(PostType type) {
        this.type = type;
    }

    public User getShareBy() {
        return shareBy;
    }

    public void setShareBy(User shareBy) {
        this.shareBy = shareBy;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<User> getLikeBy() {
        return likeBy;
    }

    public void setLikeBy(List<User> likeBy) {
        this.likeBy = likeBy;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    public Visibility getVisibility() {
        return visibility;
    }

    public void setVisibility(Visibility visibility) {
        this.visibility = visibility;
    }
}
