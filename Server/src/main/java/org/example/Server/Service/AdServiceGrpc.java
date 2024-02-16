package org.example.Server.Service;

import org.example.Server.Entity.Category;
import org.example.Server.Entity.User;
import org.example.Server.Repository.CategoryRepository;
import org.example.Server.Repository.UserRepository;
import service.Board;
import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;
import org.example.Server.Entity.Ad;
import org.example.Server.Repository.AdRepository;

import java.util.List;
import java.util.Optional;


@GrpcService
@AllArgsConstructor
public class AdServiceGrpc extends service.AdServiceGrpc.AdServiceImplBase {

    private final AdRepository adRepository;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;


    @Override
    public void createAd(Board.Ad request, StreamObserver<Board.Empty> responseObserver) {
        Optional<User> user = userRepository.findById(request.getOwnUser());
        Optional<Category> category = categoryRepository.findById(request.getCategory());

        adRepository.save(Ad.builder()
                .title(request.getTitle())
                .file(request.getFile())
                .price(request.getPrice())
                .description(request.getDescription())
                .category(category.get())
                .user(user.get())
                .build());

        responseObserver.onNext(Board.Empty.newBuilder().build());
        responseObserver.onCompleted();
    }


    @Override
    public void getAd(Board.Id request, StreamObserver<Board.Ad> responseObserver) {
        responseObserver.onNext(next(request.getId()));
        responseObserver.onCompleted();
    }

    @Override
    public void getAllAd(Board.Empty request, StreamObserver<Board.ListAd> responseObserver) {
        List<Ad> ads = adRepository.findAll();
        responseObserver.onNext(Board.ListAd.newBuilder().build());
        for (Ad ad : ads) {
            responseObserver.onNext(Board.ListAd.newBuilder().addAds(next(ad)).build());
        }
        responseObserver.onCompleted();
    }

    @Override
    public void updateAd(Board.Ad request, StreamObserver<Board.Empty> responseObserver) {
        Optional<User> user = userRepository.findById(request.getOwnUser());
        Optional<Category> category = categoryRepository.findById(request.getCategory());

        adRepository.save(Ad.builder()
                .id(request.getId())
                .title(request.getTitle())
                .file(request.getFile())
                .price(request.getPrice())
                .description(request.getDescription())
                .category(category.get())
                .user(user.get())
                .build());

        responseObserver.onNext(Board.Empty.newBuilder().build());
        responseObserver.onCompleted();
    }

    @Override
    public void deleteAd(Board.Id request, StreamObserver<Board.Empty> responseObserver) {
        adRepository.deleteById(request.getId());
        responseObserver.onNext(Board.Empty.newBuilder().build());
        responseObserver.onCompleted();
    }

    private Board.Ad next(Long id) {
        Optional<Ad> ad = adRepository.findById(id);
        return Board.Ad.newBuilder()
                .setId(id)
                .setTitle(ad.get().getTitle())
                .setFile(ad.get().getFile())
                .setPrice(ad.get().getPrice())
                .setDescription(ad.get().getDescription())
                .setCategory(ad.get().getCategory().getId())
                .build();
    }

    private Board.Ad next(Ad ad) {
        return Board.Ad.newBuilder()
                .setId(ad.getId())
                .setTitle(ad.getTitle())
                .setFile(ad.getFile())
                .setPrice(ad.getPrice())
                .setDescription(ad.getDescription())
                .setCategory(ad.getCategory().getId())
                .build();
    }
}
