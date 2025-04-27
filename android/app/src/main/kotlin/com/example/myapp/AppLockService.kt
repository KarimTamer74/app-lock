package com.example.myapp

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.view.accessibility.AccessibilityEvent
import android.content.Context

class AppLockService : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            val packageName = event.packageName?.toString() ?: return
            val lockedApps = getSharedPreferences("AppLocker", Context.MODE_PRIVATE)
                .getStringSet("lockedApps", emptySet()) ?: emptySet()
            if (lockedApps.contains(packageName)) {
                val intent = Intent(this, MainActivity::class.java).apply {
                    putExtra("packageName", packageName)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                startActivity(intent)
            }
        }
    }

    override fun onInterrupt() {}
}