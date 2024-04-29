package com.example.boardapp.presentation.ui.components

import android.widget.Toast
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.boardapp.R
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.presentation.ui.theme.Typography
import com.example.boardapp.presentation.viewmodel.DetailViewModel

@Composable
fun DetailScreen(
    modifier: Modifier = Modifier,
    viewModel: DetailViewModel = viewModel(),
) {
    val context = LocalContext.current
    val ad by viewModel.ad.collectAsState()

    val error by viewModel.error.collectAsState()
    LaunchedEffect(error) {
        if (!error.isNullOrEmpty()) {
            Toast.makeText(context, error, Toast.LENGTH_SHORT).show()
            viewModel.clearError()
        }
    }

    ad?.let {
        DescriptionCard(ad = it)
    }
}

@Composable
fun DescriptionCard(
    modifier: Modifier = Modifier,
    ad: Ad,
) {
    Column(modifier = modifier.padding(16.dp)) {
        Text(
            ad.title,
            style = Typography.headlineMedium,
        )
        Text(
            stringResource(R.string.departement_label),
        )
        Text(
            ad.price.toString(),
        )
        Text(
            stringResource(R.string.commune_label),
        )
        Text(
            ad.description,
        )
    }
}

@Preview
@Composable
fun DescriptionCardPreview(){
    val ad = Ad("scsac",false,"food","ssxsxsxsxsxsxsxsxsxsxsxsxsxsxssxsxsxsxsxsxsx xsxsx sx sxs xsx",13)
    DescriptionCard(ad = ad)
}