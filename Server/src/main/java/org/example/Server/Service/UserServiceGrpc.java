package org.example.Server.Service;

import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;
import org.example.Server.Entity.User;
import org.example.Server.Repository.AdRepository;
import org.example.Server.Repository.UserRepository;
import service.Board;

import java.util.Optional;

@GrpcService
@AllArgsConstructor
public class UserServiceGrpc extends service.UserServiceGrpc.UserServiceImplBase {

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
        responseObserver.onNext(next(request.getId()));
        responseObserver.onCompleted();
    }

    @Override
    public void getAllUser(Board.Empty request, StreamObserver<Board.ListUser> responseObserver) {
        super.getAllUser(request, responseObserver);
    }

    @Override
    public void updateUser(Board.User request, StreamObserver<Board.Empty> responseObserver) {
        userRepository.save(User.builder()
                .id(request.getId())
                .username(request.getUsername())
                .password(request.getPassword())
                .build());

        responseObserver.onNext(Board.Empty.newBuilder().build());
        responseObserver.onCompleted();
    }

    @Override
    public void deleteUser(Board.Id request, StreamObserver<Board.Empty> responseObserver) {
        userRepository.deleteById(request.getId());
        responseObserver.onNext(Board.Empty.newBuilder().build());
        responseObserver.onCompleted();
    }

    private Board.User next(Long id) {
        Optional<User> user = userRepository.findById(id);
        return Board.User.newBuilder()
                .setId(id)
                .setUsername(user.get().getUsername())
                .setPassword(user.get().getPassword())
                .build();
    }
}
