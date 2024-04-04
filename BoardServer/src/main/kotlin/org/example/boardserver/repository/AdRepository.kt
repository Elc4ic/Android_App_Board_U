package org.example.boardserver.repository

import org.example.boardserver.entity.Ad
import org.springframework.data.jpa.repository.JpaRepository

abstract class AdRepository :JpaRepository<Ad,Long>{
}