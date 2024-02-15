package org.example.Server.Service;

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
            responseObserver.onNext(Board.ListAd.newBuilder().addAds(next(ad.getId())).build());
        }
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
}
