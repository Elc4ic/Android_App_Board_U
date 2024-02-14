package org.example.Server.Controller;

import lombok.AllArgsConstructor;
import org.example.Server.Entity.Category;
import org.example.Server.Service.CategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/categories")
@AllArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    @GetMapping
    public ResponseEntity<List<Category>> read() {
        return new ResponseEntity<>(categoryService.readAll(), HttpStatus.OK);
    }
}
