package com.example.boardapp.presentation.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.material3.ElevatedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.example.boardapp.R
import com.example.boardapp.presentation.ui.theme.Typography

@Composable
fun AboutScreen(modifier: Modifier = Modifier) {
    val context = LocalContext.current
    val uriHandler = LocalUriHandler.current

    Column(
        modifier = modifier.fillMaxWidth().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Text(
            stringResource(R.string.app_name),
            style = Typography.titleLarge,
            textAlign = TextAlign.Justify,
            modifier = Modifier.fillMaxWidth()
        )
        Text(
            stringResource(R.string.about),
            textAlign = TextAlign.Justify,
            modifier = Modifier.fillMaxWidth()
        )
        Row(
            horizontalArrangement = Arrangement.Center,
            modifier = Modifier.fillMaxWidth(),
        ) {
            ElevatedButton(
                onClick = { uriHandler.openUri(context.getString(R.string.project_url)) }
            ) {
                Text(stringResource(R.string.source_code))
            }
        }
    }
}
