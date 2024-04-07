package org.example.Server.Repository;

import org.example.Server.Entity.Ad;
import org.example.Server.Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdRepository extends JpaRepository<Ad,Long> {
    List<Ad> findByCategoryId(Long id);

    List<Ad> findByOwnUser(User user);



}
