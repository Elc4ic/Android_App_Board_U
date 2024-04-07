package com.example.boardapp.presentation.ui.components.common.card

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.example.boardapp.R
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.presentation.ui.theme.Typography

@Composable
fun AdCard(modifier: Modifier = Modifier,
           ad: Ad = Ad(),
           onFavorite: (Ad) -> Unit = {},
           onClick: (Ad) -> Unit = {},
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier.fillMaxWidth().clickable { onClick(ad) }.padding(16.dp)
    ) {
        Column(modifier = Modifier.weight(2f)) {
            Text(ad.title, style = Typography.headlineMedium)
            Text(ad.price.toString(), style = Typography.headlineMedium)
            Text(ad.id, modifier = Modifier.padding(top = 16.dp))
        }
        IconButton(onClick = { onFavorite(ad) }) {
            if (ad.isFavorite) {
                Icon(
                    painterResource(R.drawable.ic_baseline_star_24),
                    contentDescription = stringResource(R.string.favorite_icon_description),
                )
            } else {
                Icon(
                    painterResource(R.drawable.ic_baseline_star_border_24),
                    contentDescription = stringResource(R.string.favorite_icon_description),
                )
            }
        }
    }
}
