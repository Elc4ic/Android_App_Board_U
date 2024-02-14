package org.example.Server.Service;

import Service.AdGrpcService;
import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;
import org.example.Server.Entity.Ad;
import org.example.Server.Repository.AdRepository;

import java.util.List;
import java.util.Optional;


@GrpcService
@AllArgsConstructor
public class ServiceGrpc extends Service.AdServiceGrpc.AdServiceImplBase {

    private final AdRepository adRepository;
    @Override
    public void getAd(AdGrpcService.AdRequest request, StreamObserver<AdGrpcService.Ad> responseObserver) {
        responseObserver.onNext(next(request.getId()));
        responseObserver.onCompleted();
    }

    private AdGrpcService.Ad next(Long id) {
        Optional<Ad> ad = adRepository.findById(id);
        return AdGrpcService.Ad.newBuilder()
                .setId(id)
                .setTitle(ad.get().getTitle())
                .setFile(ad.get().getFile())
                .setPrice(ad.get().getPrice())
                .setDescription(ad.get().getDescription())
                .setCategory(ad.get().getCategory().getId())
                .build();
    }

    @Override
    public void getAllAd(AdGrpcService.AllAdRequest request, StreamObserver<AdGrpcService.Ads> responseObserver) {
        List<Ad> ads = adRepository.findAll();
        responseObserver.onNext(AdGrpcService.Ads.newBuilder().build());
        for (Ad ad: ads) {
            responseObserver.onNext(AdGrpcService.Ads.newBuilder().addAds(next(ad.getId())).build());
        }
        responseObserver.onCompleted();
    }
}
