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
    @OneToMany(mappedBy = "ownUser", cascade = CascadeType.ALL)
    private Set<Ad> ownAds;
    @OneToMany(cascade = CascadeType.ALL)
    private Set<Ad> favAds;
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Comment> comments;
}
