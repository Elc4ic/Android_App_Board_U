package org.example.Server.Controller;

import lombok.AllArgsConstructor;
import org.example.Server.DTO.AdDTO;
import org.example.Server.Entity.Ad;
import org.example.Server.Service.AdService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@AllArgsConstructor
public class AdController {

    private final AdService adService;

    @PostMapping
    public ResponseEntity<Ad> create(@RequestBody AdDTO dto) {
        return mappingResponseAd(adService.create(dto));
    }

    @GetMapping("/category/{id}")
    public ResponseEntity<List<Ad>> readByCategoryId(@PathVariable Long id) {
        return mappingResponseAdList(adService.readByCategoryId(id));
    }

    @GetMapping("ads")
    public ResponseEntity<List<Ad>> read() {
        return mappingResponseAdList(adService.readAll());
    }

    @PutMapping
    public ResponseEntity<Ad> update(@RequestBody Ad ad) {
        return mappingResponseAd(adService.update(ad));
    }

    @DeleteMapping("/{id}")
    private HttpStatus delete(@PathVariable Long id) {
        adService.delete(id);
        return HttpStatus.OK;
    }

    private ResponseEntity<Ad> mappingResponseAd(Ad ad) {
        return new ResponseEntity<>(ad, HttpStatus.OK);
    }

    private ResponseEntity<List<Ad>> mappingResponseAdList(List<Ad> adList) {
        return new ResponseEntity<>(adList, HttpStatus.OK);
    }

/*    @MessageMapping("/chat")
    public void sendMessage(ChatMessage message) {
        String topic = message.getTopic();
        this.template.convertAndSend("/topic/" + topic, message);
    }

    @RequestMapping(path="/chat", method= RequestMethod.POST)
    public void greet(@RequestBody ChatMessage message) {
        String topic = message.getTopic();
        this.template.convertAndSend("/topic/" + topic, message);
    }*/
}
