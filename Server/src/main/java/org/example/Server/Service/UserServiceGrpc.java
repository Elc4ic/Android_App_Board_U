package org.example.Server.Service;

import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;
import org.example.Server.DTO.UserDTO;
import org.example.Server.Entity.User;
import org.example.Server.Repository.UserRepository;
import service.Board;

@GrpcService
@AllArgsConstructor
public class UserServiceGrpc extends service.UserServiceGrpc.UserServiceImplBase{

    private final UserRepository userRepository;
    @Override
    public void createUser(Board.User request, StreamObserver<Board.Empty> responseObserver) {
        userRepository.save(User.builder()
                .username(request.getUsername())
                .password(request.getPassword())
                .build());

        responseObserver.onNext(Board.Empty.newBuilder().build());
        responseObserver.onCompleted();
    }

    @Override
    public void getUser(Board.Id request, StreamObserver<Board.User> responseObserver) {
        super.getUser(request, responseObserver);
    }

    @Override
    public void getAllUser(Board.Empty request, StreamObserver<Board.ListUser> responseObserver) {
        super.getAllUser(request, responseObserver);
    }

    @Override
    public void updateAd(Board.User request, StreamObserver<Board.Empty> responseObserver) {
        super.updateAd(request, responseObserver);
    }

    @Override
    public void deleteAd(Board.Id request, StreamObserver<Board.Empty> responseObserver) {
        super.deleteAd(request, responseObserver);
    }
}
