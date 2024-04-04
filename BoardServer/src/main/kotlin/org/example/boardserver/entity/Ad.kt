package org.example.boardserver.entity

import jakarta.persistence.Entity
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table

@Entity
@Table(name = "ads")
class Ad(

    var title: String,
    var price: Int,
    var description: String? = null,
    var is_favorite: Boolean = false,

    @ManyToOne
    @JoinColumn(name = "department_id")
    val category: Category
) : BaseAuditEntity<Long>()