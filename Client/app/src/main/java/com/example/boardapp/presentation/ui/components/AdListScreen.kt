package com.example.boardapp.presentation.ui.components

import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Clear
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.paging.compose.collectAsLazyPagingItems
import androidx.paging.compose.itemContentType
import androidx.paging.compose.itemKey
import com.example.boardapp.R
import com.example.boardapp.presentation.ui.components.common.card.AdCard
import com.example.boardapp.presentation.viewmodel.AdListViewModel

@Composable
fun AdListScreen(
    modifier: Modifier = Modifier,
    navController: NavHostController,
    viewModel: AdListViewModel = viewModel()
) {
    val context = LocalContext.current
    val stations = viewModel.pages.collectAsLazyPagingItems()
    val search by viewModel.search.collectAsState()
    val lazyListState = rememberLazyListState()

    val error by viewModel.error.collectAsState()

    LaunchedEffect(error) {
        if (!error.isNullOrEmpty()) {
            Toast.makeText(context, error, Toast.LENGTH_SHORT).show()
            viewModel.clearError()
        }
    }

    Column(modifier = modifier.fillMaxWidth()) {
        SearchBar(
            search = search,
            onSearchChange = { viewModel.updateSearch(it) },
            onSearchClear = { viewModel.updateSearch("") },
            modifier =
            Modifier.fillMaxWidth()
                .padding(16.dp)
                .background(
                    MaterialTheme.colorScheme.background,
                    shape = RoundedCornerShape(4.dp)
                ),
        )
        LazyColumn(
            state = lazyListState,
            modifier = Modifier.fillMaxSize(),
        ) {
            items(
                count = stations.itemCount,
                key = stations.itemKey { it.id },
                contentType = stations.itemContentType { "station" },
            ) { idx ->
                val item = stations[idx]!!
                Column {
                    AdCard(
                        ad = item,
                        onFavorite = { ad ->
                            viewModel.makeFavorite(ad.id, !ad.isFavorite)
                        },
                        onClick = { navController.navigate(NavItem.Detail(item.id).route) }
                    )
                    HorizontalDivider()
                }
            }
        }
    }
}

@Composable
fun SearchBar(
    modifier: Modifier = Modifier,
    search: String = "",
    onSearchChange: (String) -> Unit = {},
    onSearchClear: () -> Unit = {},
) {
    OutlinedTextField(
        value = search,
        onValueChange = onSearchChange,
        placeholder = { Text(stringResource(R.string.search_ad_hint)) },
        keyboardOptions =
        KeyboardOptions(keyboardType = KeyboardType.Text, imeAction = ImeAction.Search),
        leadingIcon = { Icon(imageVector = Icons.Default.Search, contentDescription = "Search") },
        trailingIcon = {
            if (search.isNotEmpty()) {
                IconButton(
                    onClick = onSearchClear,
                ) {
                    Icon(imageVector = Icons.Default.Clear, contentDescription = "Clear")
                }
            }
        },
        singleLine = true,
        maxLines = 1,
        modifier = modifier,
    )
}