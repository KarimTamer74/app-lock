package com.example.myapp

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.provider.Settings
import android.util.Log

class MainActivity : FlutterActivity() {
    private val CHANNEL = "appLocker"
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "showLockScreen" -> {
                    val packageName = call.argument<String>("packageName")
                    Log.d(TAG, "showLockScreen called for package: $packageName")
                    if (packageName != null) {
                        runOnUiThread {
                            // Pass packageName as an argument in the route
                            flutterEngine.navigationChannel.pushRoute("/lock?packageName=$packageName")
                        }
                    }
                    result.success(true)
                }
                "enableAccessibility" -> {
                    Log.d(TAG, "enableAccessibility called")
                    startActivity(Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS))
                    result.success(true)
                }
                "getInstalledApps" -> {
                    val apps = getInstalledApplications()
                    result.success(apps)
                }
                "openApp" -> {
                    val packageName = call.argument<String>("packageName")
                    Log.d(TAG, "openApp called for package: $packageName")
                    if (packageName != null) {
                        val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
                        if (launchIntent != null) {
                            startActivity(launchIntent)
                        } else {
                            Log.d(TAG, "No launch intent for $packageName")
                        }
                    }
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getInstalledApplications(): List<Map<String, String>> {
        val packageManager = packageManager
        val apps = packageManager.getInstalledApplications(0)
        val appList = mutableListOf<Map<String, String>>()
        for (app in apps) {
            val appInfo = mapOf(
                "appName" to (packageManager.getApplicationLabel(app).toString()),
                "packageName" to app.packageName
            )
            appList.add(appInfo)
        }
        return appList
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val packageName = intent.getStringExtra("packageName")
        Log.d(TAG, "onCreate called with packageName: $packageName")
    }
}