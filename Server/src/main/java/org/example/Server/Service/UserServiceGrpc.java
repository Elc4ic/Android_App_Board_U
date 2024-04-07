package org.example.Server.Service;

import com.google.protobuf.StringValue;
import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;
import org.example.Server.Entity.Ad;
import org.example.Server.Entity.Role;
import org.example.Server.Entity.User;
import org.example.Server.Repository.AdRepository;
import org.example.Server.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import service.Board;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@GrpcService
@AllArgsConstructor
public class UserServiceGrpc extends service.UserServiceGrpc.UserServiceImplBase implements UserDetailsService {


    private final UserRepository userRepository;

    @Autowired
    private PasswordEncoder encoder;

    @Override
    public void getUser(Board.Id request, StreamObserver<Board.User> responseObserver) {
        responseObserver.onNext(next(request.getId()));
        responseObserver.onCompleted();
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

    @Override
    public void createCommentOnUser(Board.Comment request, StreamObserver<Board.Empty> responseObserver) {
        super.createCommentOnUser(request, responseObserver);
    }

    @Override
    public void getAdByUser(Board.User request, StreamObserver<Board.ListAd> responseObserver) {
        super.getAdByUser(request, responseObserver);
    }

    private Board.User next(Long id) {
        Optional<User> user = userRepository.findById(id);
        return Board.User.newBuilder()
                .setId(id)
                .setUsername(user.get().getUsername())
                .setPassword(user.get().getPassword())
                .build();
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Set<Role> roles = new HashSet<>();
        roles.add(new Role(1, "USER"));
        return new User(1L,
                username,
                encoder.encode("password"),
                "",
                "",
                0f,
                new HashSet<>(),
                new HashSet<>(),
                new HashSet<>(),
                roles);
    }
}
