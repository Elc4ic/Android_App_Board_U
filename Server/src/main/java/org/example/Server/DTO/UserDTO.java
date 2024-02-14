package org.example.Server.DTO;

import lombok.Data;
import org.example.Server.Entity.Ad;

import java.util.Set;

@Data
public class UserDTO {
    private String username;
    private String password;
    private Set<Ad> user_ads;
}
