package org.example.Server.Service;

import lombok.AllArgsConstructor;
import org.example.Server.DTO.UserDTO;
import org.example.Server.Entity.User;
import org.example.Server.Repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public User create(UserDTO dto) {
        return userRepository.save(User.builder()
                .username(dto.getUsername())
                .password(dto.getPassword())
                .build());
    }

    public List<User> readAll() {
        return userRepository.findAll();
    }
    public Optional<User> readById(Long id) {
        return userRepository.findById(id);
    }

    public User update(User user) {
        return userRepository.save(user);
    }

    public void delete(Long id) {
        userRepository.deleteById(id);
    }
}
