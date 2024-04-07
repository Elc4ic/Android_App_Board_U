package org.example.Server.Utils;

import org.example.Server.Entity.Ad;
import org.example.Server.Entity.User;
import service.Board;

import java.util.Optional;

public class GrpcBuilder {
    public static Board.Ad next(Ad ad) {
        return Board.Ad.newBuilder()
                .setId(ad.getId())
                .setTitle(ad.getTitle())
                .setFile(ad.getFile())
                .setPrice(ad.getPrice())
                .setDescription(ad.getDescription())
                .setCategory(ad.getCategory().getId())
                .build();
    }

    public static Board.User next(User user) {
        return Board.User.newBuilder()
                .setId(user.getId())
                .setUsername(user.getUsername())
                .setPassword(user.getPassword())
                .setAddress(user.getAddress())
                .setPhone(user.getPhone())
                .setRating(user.getRating())
                /*.setOwnAd()
                .setFavAd()
                .setComments()
                .setAuthorities()*/
                .build();
    }
}
