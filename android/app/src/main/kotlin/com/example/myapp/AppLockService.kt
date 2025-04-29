package com.example.myapp

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import android.view.accessibility.AccessibilityEvent
import android.content.Context
import android.util.Log
import org.json.JSONArray
import com.example.myapp.MainActivity

class AppLockService : AccessibilityService() {
    private val TAG = "AppLockService"
    private var isLockScreenActive = false

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        Log.d(TAG, "onAccessibilityEvent triggered: ${event?.eventType}")
        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            val packageName = event.packageName?.toString() ?: return
            Log.d(TAG, "App opened: $packageName")

            // تجاهل التطبيق نفسه
            if (packageName == "com.example.myapp") {
                Log.d(TAG, "Ignoring myapp itself")
                return
            }

            // استرجاع التطبيقات المقفولة من SharedPreferences
            val sharedPreferences = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val lockedAppsJson = sharedPreferences.getString("flutter.lockedApps", "[]") ?: "[]"
            val lockedApps = try {
                JSONArray(lockedAppsJson).let { jsonArray ->
                    (0 until jsonArray.length()).map { jsonArray.getString(it) }.toSet()
                }
            } catch (e: Exception) {
                Log.e(TAG, "Error parsing locked apps JSON: $e")
                emptySet<String>()
            }

            Log.d(TAG, "Locked apps: $lockedApps")

            // تحقق إذا كان التطبيق مقفولًا
            if (lockedApps.contains(packageName)) {
                Log.d(TAG, "Locked app detected! Launching LockScreen for $packageName")
                
                if (!isLockScreenActive) {
                    isLockScreenActive = true
                    val intent = Intent(this, MainActivity::class.java).apply {
                        putExtra("packageName", packageName)
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    }
                    startActivity(intent)
                }
            } else {
                Log.d(TAG, "App $packageName is not locked")
            }
        }
    }

    // ✅ دالة جديدة عشان نفتح التطبيق مباشرة بدون مشاكل
    fun openApp(packageName: String) {
        Log.d(TAG, "Opening app: $packageName")
        val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
        if (launchIntent != null) {
            launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(launchIntent)
        } else {
            Log.e(TAG, "No launch intent found for package: $packageName")
        }
    }

    fun resetLockScreenState() {
        isLockScreenActive = false
        Log.d(TAG, "LockScreen state reset to false")
    }

    override fun onInterrupt() {
        Log.d(TAG, "Service interrupted")
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        Log.d(TAG, "Accessibility Service connected")
    }
}
