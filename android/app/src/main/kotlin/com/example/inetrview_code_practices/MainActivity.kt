package com.example.inetrview_code_practices

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Build
import android.widget.Toast

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/platform"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

           when (call.method) {

                "getPlatformVersion" -> {
                    val version = getPlatformVersion()
                    result.success(version)
                }

                "showToastonTap" -> {
                    val message = call.argument<String>("message") ?: "Hello"
                    Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
                    result.success("Toast Shown")
                }

                else -> {
                    result.notImplemented()
                }
           }

        }
    }

    private fun getPlatformVersion(): String {
        return "Android ${Build.VERSION.RELEASE}"
    }
}
