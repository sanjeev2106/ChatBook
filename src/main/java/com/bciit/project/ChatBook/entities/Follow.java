package com.bciit.project.ChatBook.entities;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Follow {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    private Date date = new Date();

    @ManyToOne
    @JoinColumn(name = "follow_to")
    private User followTo;

    @ManyToOne
    @JoinColumn(name = "follow_by")
    private User followBy;


    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public User getFollowTo() {
        return followTo;
    }

    public void setFollowTo(User followTo) {
        this.followTo = followTo;
    }

    public User getFollowBy() {
        return followBy;
    }

    public void setFollowBy(User followBy) {
        this.followBy = followBy;
    }
}
