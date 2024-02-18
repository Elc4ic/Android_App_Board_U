package org.example.Server.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Entity
@Table(name = "chats")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Chat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long idMe;
    private Long idOther;
    @OneToMany(mappedBy = "chat", cascade = CascadeType.ALL)
    private Set<Message> messages;
}
