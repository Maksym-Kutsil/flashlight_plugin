package com.maksymkutsil.flashlight_plugin

import android.content.Context
import android.content.pm.PackageManager
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * Android implementation of the flashlight plugin.
 *
 * The class registers a [MethodChannel] that mirrors the one used on
 * the Dart side and uses [CameraManager.setTorchMode] to drive the
 * device torch. No camera permission is required at runtime for
 * `setTorchMode`, but a `<uses-feature>` flag is declared in the
 * plugin manifest so the Play Store knows the app uses the flash.
 */
class FlashlightPlugin :
    FlutterPlugin,
    MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        channel = MethodChannel(
            binding.binaryMessenger,
            CHANNEL_NAME,
        )
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        applicationContext = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            METHOD_TURN_ON -> setTorchMode(true, result)
            METHOD_TURN_OFF -> setTorchMode(false, result)
            else -> result.notImplemented()
        }
    }

    private fun setTorchMode(enabled: Boolean, result: Result) {
        val context = applicationContext
        if (context == null) {
            result.error(
                ERROR_NO_CONTEXT,
                "Application context is not attached to the Flutter engine.",
                null,
            )
            return
        }

        if (!context.packageManager.hasSystemFeature(
                PackageManager.FEATURE_CAMERA_FLASH,
            )
        ) {
            result.error(
                ERROR_NO_FLASH,
                "This device does not have a flashlight.",
                null,
            )
            return
        }

        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        try {
            val cameraId = cameraManager.cameraIdList.firstOrNull { id ->
                cameraManager
                    .getCameraCharacteristics(id)
                    .get(CameraCharacteristics.FLASH_INFO_AVAILABLE) == true
            }
            if (cameraId == null) {
                result.error(
                    ERROR_NO_FLASH,
                    "No camera with a flash unit was found.",
                    null,
                )
                return
            }
            cameraManager.setTorchMode(cameraId, enabled)
            result.success(null)
        } catch (error: Exception) {
            result.error(
                ERROR_TORCH,
                error.message ?: "Failed to switch the torch.",
                null,
            )
        }
    }

    private companion object {
        const val CHANNEL_NAME = "com.maksymkutsil.flashlight_plugin/flashlight"
        const val METHOD_TURN_ON = "turnOn"
        const val METHOD_TURN_OFF = "turnOff"
        const val ERROR_NO_CONTEXT = "NO_CONTEXT"
        const val ERROR_NO_FLASH = "NO_FLASH"
        const val ERROR_TORCH = "TORCH_ERROR"
    }
}
