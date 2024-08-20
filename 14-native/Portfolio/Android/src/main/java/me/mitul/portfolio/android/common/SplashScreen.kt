package me.mitul.portfolio.android.common

import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.keyframes
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay
import me.mitul.portfolio.android.R

@Composable
fun SplashScreen(visible: Boolean = true, content: @Composable () -> Unit) {
    var isVisible by rememberSaveable { mutableStateOf(value = visible) }
    if (!isVisible) {
        content()
    } else {
        Surface {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(all = 16.dp),
                verticalArrangement = Arrangement.Center,
                horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                AppLogo()
                ContinueButton { isVisible = false }
            }
        }
    }
}

@Composable
private fun AppLogo(animate: Boolean = true) {
    val transition =
        rememberInfiniteTransition(label = stringResource(id = R.string.transition))
    val angle by transition.animateFloat(
        label = stringResource(id = R.string.animate),
        initialValue = 1.0f, targetValue = 1.2f,
        animationSpec = infiniteRepeatable(
            repeatMode = RepeatMode.Reverse,
            animation = keyframes { durationMillis = 800 },
        )
    )
    Image(
        painter = painterResource(id = R.drawable.ic_launcher),
        contentDescription = stringResource(id = R.string.app_logo),
        modifier = Modifier
            .aspectRatio(ratio = 1.0f)
            .padding(all = 50.dp)
            .scale(scale = if (animate) angle else 0.0f)
    )
}

@Composable
private fun ContinueButton(onClick: () -> Unit) {
    val localOnClick by rememberUpdatedState(newValue = onClick)
    Button(
        onClick = localOnClick,
        modifier = Modifier.fillMaxWidth(),
    ) {
        Text(text = stringResource(id = R.string.btn_continue))
    }
    LaunchedEffect(key1 = Unit) {
        delay(timeMillis = 4_000)
        localOnClick()
    }
}

@Preview
@Composable
private fun SplashScreen_Preview() = SplashScreen {}
