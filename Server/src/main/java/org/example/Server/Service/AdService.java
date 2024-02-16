package org.example.Server.Service;

import lombok.AllArgsConstructor;
import org.example.Server.DTO.AdDTO;
import org.example.Server.Entity.Ad;
import org.example.Server.Repository.AdRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class AdService {

    private final AdRepository adRepository;

    private final CategoryService categoryService;

    public Ad create(AdDTO dto) {
        return adRepository.save(Ad.builder()
                .title(dto.getTitle())
                .file(dto.getFile())
                .price(dto.getPrice())
                .description(dto.getDescription())
                .category(dto.getCategory())
                .build());
    }

    public List<Ad> readAll() {
        return adRepository.findAll();
    }

    public List<Ad> readByCategoryId(Long id) {
        return adRepository.findByCategoryId(id);
    }

    public Ad update(Ad ad) {
        return adRepository.save(ad);
    }

    public void delete(Long id) {
        adRepository.deleteById(id);
    }

}
