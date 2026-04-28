package com.example.iconschange

import android.app.Activity
import android.content.Intent
import android.os.Bundle

class LauncherActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val targetPackage = intent.getStringExtra("target_package")

        if (targetPackage != null) {
            val launchIntent = packageManager.getLaunchIntentForPackage(targetPackage)
            if (launchIntent != null) {
                launchIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                startActivity(launchIntent)
            }
        }

        finish()
    }
}