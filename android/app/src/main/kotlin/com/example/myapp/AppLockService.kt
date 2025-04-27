package com.example.myapp

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.view.accessibility.AccessibilityEvent
import android.content.Context
import android.util.Log

class AppLockService : AccessibilityService() {
    private val TAG = "AppLockService"

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        Log.d(TAG, "onAccessibilityEvent triggered: ${event?.eventType}")
        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            val packageName = event.packageName?.toString() ?: return
            Log.d(TAG, "App opened: $packageName")
            // تجاهل التطبيق نفسه (myapp) عشان ما يقفلش نفسه
            if (packageName == "com.example.myapp") {
                Log.d(TAG, "Ignoring myapp itself")
                return
            }
            val lockedApps = getSharedPreferences("AppLocker", Context.MODE_PRIVATE)
                .getStringSet("lockedApps", emptySet()) ?: emptySet()
            Log.d(TAG, "Locked apps: $lockedApps")
            if (lockedApps.contains(packageName)) {
                Log.d(TAG, "Locked app detected! Launching LockScreen for $packageName")
                val intent = Intent(this, MainActivity::class.java).apply {
                    putExtra("packageName", packageName)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                startActivity(intent)
            } else {
                Log.d(TAG, "App $packageName is not locked")
            }
        }
    }

    override fun onInterrupt() {
        Log.d(TAG, "Service interrupted")
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        Log.d(TAG, "Accessibility Service connected")
    }
}