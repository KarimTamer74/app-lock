package com.example.myapp

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "appLocker"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openApp") {
                val packageName = call.argument<String>("packageName")
                if (packageName != null) {
                    val service = getSystemService(Context.ACCESSIBILITY_SERVICE) as? AppLockService
                    service?.openApp(packageName)
                    result.success(null)
                } else {
                    result.error("INVALID_PACKAGE", "Package name is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
