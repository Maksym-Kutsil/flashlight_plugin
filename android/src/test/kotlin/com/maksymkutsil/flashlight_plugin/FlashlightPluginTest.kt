package com.maksymkutsil.flashlight_plugin

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.mockito.Mockito
import kotlin.test.Test

/**
 * Unit test for [FlashlightPlugin]. The plugin only ever responds to
 * `turnOn` and `turnOff`, so any other channel call must surface as
 * `notImplemented` to the Dart side.
 */
internal class FlashlightPluginTest {
    @Test
    fun onMethodCall_unknownMethod_isNotImplemented() {
        val plugin = FlashlightPlugin()

        val call = MethodCall("getPlatformVersion", null)
        val mockResult: MethodChannel.Result =
            Mockito.mock(MethodChannel.Result::class.java)
        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).notImplemented()
    }
}
