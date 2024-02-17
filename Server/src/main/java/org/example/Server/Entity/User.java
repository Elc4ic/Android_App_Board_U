package org.example.Server.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Entity
@Table(name = "users")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    private String username;
    private String password;
    private String address;
    private String phone;
    private Float rating;
    @OneToMany(mappedBy = "own_user", cascade = CascadeType.ALL)
    private Set<Ad> own_ads;
    @OneToMany(cascade = CascadeType.ALL)
    private Set<Ad> fav_ads;
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Comment> comments;

    public void setOwnAds(Set<Ad> ads) {
        this.own_ads = ads;

        for(Ad a : ads) {
        }
    }
    public void setFavAds(Set<Ad> ads) {
        this.fav_ads = ads;

        for(Ad a : ads) {
        }
    }
    public void setComments(Set<Comment> comments) {
        this.comments = comments;

        for(Comment c : comments) {
        }
    }
}
