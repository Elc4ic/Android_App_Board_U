package org.example.Server.Service;

import io.grpc.stub.StreamObserver;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import net.devh.boot.grpc.server.service.GrpcService;
import org.example.Server.Entity.Role;
import org.example.Server.Entity.User;
import org.example.Server.Repository.RoleRepository;
import org.example.Server.Repository.UserRepository;
import org.example.Server.Utils.GrpcBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import service.Board;

import java.util.HashSet;
import java.util.Set;

@GrpcService
@Transactional
@AllArgsConstructor
public class AuthServiceGrpc extends service.AuthServiceGrpc.AuthServiceImplBase {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;
    private TokenService tokenService;
    private AuthenticationManager authenticationManager;


    @Override
    public void login(Board.LoginRequest request, StreamObserver<Board.LoginRespond> responseObserver) {
        String username = request.getUsername();
        String password = request.getPassword();
        Authentication auth = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(username, password)
        );
        String token = tokenService.generateJwt(auth);
        User user = userRepository.findByUsername(username).get();
        Board.User user1 = Board.User.newBuilder()
                .setUsername(user.getUsername())
                .setPassword(user.getPassword())
                .build();
        Board.LoginRespond.newBuilder().setUser(user1).setToken(token).build();
        responseObserver.onCompleted();
    }

    @Override
    public void registrate(Board.RegisterRequest request, StreamObserver<Board.User> responseObserver) {
        String username = request.getUsername();
        String password = request.getPassword();
        String encodedPassword = passwordEncoder.encode(password);
        Role userRole = roleRepository.findByAuthority("USER").get();
        Set<Role> autorities = new HashSet<>();
        autorities.add(userRole);
        User user = new User(1L,
                username,
                encodedPassword,
                "",
                "",
                0f,
                new HashSet<>(),
                new HashSet<>(),
                new HashSet<>(),
                autorities);
        userRepository.save(user);
        responseObserver.onNext(GrpcBuilder.next(user));
        responseObserver.onCompleted();
    }
}
