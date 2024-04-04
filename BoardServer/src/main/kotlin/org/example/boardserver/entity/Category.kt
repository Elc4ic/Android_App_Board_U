package org.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "category")
class Category(

    val name: String,

    @OneToMany(
        mappedBy = "category",
        fetch = FetchType.LAZY,
        orphanRemoval = true,
        cascade = [CascadeType.ALL]
    )
    val ads: MutableList<Ad> = mutableListOf()
) : BaseAuditEntity<Long>() {

    fun addEmployee(block: Category.() -> Ad) {
        ads.add(block())
    }

    fun setEmployees(block: Category.() -> MutableSet<Ad>) {
        ads.clear()
        ads.addAll(block())
    }
}