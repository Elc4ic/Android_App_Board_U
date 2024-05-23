package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "ads")
class Ad(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    var title: String,
    var price: Long,
    var description: String? = null,
    var is_active: Boolean = true,
    var views: Int = 0,
    var created: String,

/*    @ElementCollection
    val images: List<String>,*/

    @ManyToOne
    @JoinColumn(name = "users_id")
    val user: User,

    @ManyToOne
    @JoinColumn(name = "category_id")
    val category: Category
)