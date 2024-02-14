package org.example.Server.Controller;

import lombok.AllArgsConstructor;
import org.example.Server.DTO.UserDTO;
import org.example.Server.Entity.Ad;
import org.example.Server.Entity.User;
import org.example.Server.Service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/users")
@AllArgsConstructor
public class UserController {


    private final UserService userService;

    @PostMapping
    public ResponseEntity<User> create(@RequestBody UserDTO dto) {
        return mappingResponseUser(userService.create(dto));
    }

    @GetMapping
    public ResponseEntity<List<User>> read() {
        return mappingResponseUserList(userService.readAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<User>> readUser(@PathVariable Long id) {
        return new ResponseEntity<>(userService.readById(id), HttpStatus.OK);
    }

    @PutMapping
    public ResponseEntity<User> update(@RequestBody User user) {
        return mappingResponseUser(userService.update(user));
    }

    @DeleteMapping("/{id}")
    private HttpStatus delete(@PathVariable Long id) {
        userService.delete(id);
        return HttpStatus.OK;
    }

    //mappings
    private ResponseEntity<User> mappingResponseUser(User user) {
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    private ResponseEntity<List<User>> mappingResponseUserList(List<User> userList) {
        return new ResponseEntity<>(userList, HttpStatus.OK);
    }

}
