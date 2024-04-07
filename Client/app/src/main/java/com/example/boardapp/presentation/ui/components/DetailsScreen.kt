package com.example.boardapp.presentation.ui.components

import android.widget.Toast
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.boardapp.R
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.presentation.ui.theme.Typography
import com.example.boardapp.presentation.viewmodel.DetailViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DetailScreen(
    modifier: Modifier = Modifier,
    viewModel: DetailViewModel = viewModel(),
) {
    val context = LocalContext.current
    val ad by viewModel.ad.collectAsState()
    val scaffoldState =
        rememberBottomSheetScaffoldState(
            bottomSheetState = rememberStandardBottomSheetState(initialValue = SheetValue.Expanded),
        )


    val error by viewModel.error.collectAsState()
    LaunchedEffect(error) {
        if (!error.isNullOrEmpty()) {
            Toast.makeText(context, error, Toast.LENGTH_SHORT).show()
            viewModel.clearError()
        }
    }

    ad?.let {
        BottomSheetScaffold(
            scaffoldState = scaffoldState,
            sheetContent = { DescriptionCard(ad = it) }
        ) {}
    }
}

@Composable
fun DescriptionCard(
    modifier: Modifier = Modifier,
    ad: Ad,
) {
    ConstraintLayout(modifier = modifier.padding(16.dp)) {
        val (
            title,
            priceLabel,
            price,
            descriptionLabel,
            description,
        ) = createRefs()
        Text(
            ad.title,
            style = Typography.headlineMedium,
            modifier =
            Modifier.constrainAs(title) {
                top.linkTo(parent.top)
                start.linkTo(parent.start)
            }
        )
        Text(
            stringResource(R.string.departement_label),
            modifier =
            Modifier.constrainAs(priceLabel) {
                top.linkTo(title.bottom, margin = 16.dp)
                start.linkTo(parent.start)
            }
        )
        Text(
            ad.price.toString(),
            modifier =
            Modifier.constrainAs(price) {
                top.linkTo(priceLabel.top)
                bottom.linkTo(priceLabel.bottom)
                start.linkTo(priceLabel.end, margin = 16.dp)
            }
        )
        Text(
            stringResource(R.string.commune_label),
            modifier =
            Modifier.constrainAs(descriptionLabel) {
                top.linkTo(priceLabel.bottom, margin = 16.dp)
                start.linkTo(parent.start)
            }
        )
        Text(
            ad.description,
            modifier =
            Modifier.constrainAs(description) {
                top.linkTo(descriptionLabel.top)
                bottom.linkTo(descriptionLabel.bottom)
                start.linkTo(price.start)
            }
        )
    }
}