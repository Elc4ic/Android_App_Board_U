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

/*    @GetMapping(value = "/start_ads", produces = "application/json")
    public AdListResponse index() {
        Ad firstRoom = new Ad(0L, "First ad", "hhhty", 1500, "best thing for your1",new Category(0L,"dwf"));
        Ad secondRoom = new Ad(1L, "Second ad", "45ty", 1600, "best thing for your2",new Category(1L,"deff"));
        Ad thirdRoom = new Ad(2L, "Third ad", "hhgdy", 300, "best thing for your3",new Category(2L,"dewf"));

        return new AdListResponse(List.of(firstRoom, secondRoom, thirdRoom));
    }*/

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
