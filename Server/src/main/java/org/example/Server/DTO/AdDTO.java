package org.example.Server.DTO;

import lombok.Data;
import org.example.Server.Entity.Category;
import org.example.Server.Entity.User;

@Data
public class AdDTO {
    private String title;
    private Integer file;
    private Integer price;
    private String description;
    private Category category;
    private User user;
}
