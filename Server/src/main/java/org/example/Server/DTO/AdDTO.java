package org.example.Server.DTO;

import lombok.Data;

@Data
public class AdDTO {
    private String title;
    private Integer file;
    private Integer price;
    private String description;
    private Long categoryId;
}
