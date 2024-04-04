package org.example.boardserver.repository

import org.example.boardserver.entity.Category
import org.springframework.data.jpa.repository.JpaRepository

abstract class CategoryRepository : JpaRepository<Category,Long>{

}