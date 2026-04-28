package com.example.iconschange

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper

class ShortcutActivity : Activity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        val targetPackage = intent.getStringExtra("target_package")
        
        if (targetPackage != null) {
            val launchIntent = packageManager.getLaunchIntentForPackage(targetPackage)
            if (launchIntent != null) {
                // تأخير بسيط عشان الـ Activity تفتح بشكل صحيح
                Handler(Looper.getMainLooper()).postDelayed({
                    startActivity(launchIntent)
                    finish()
                }, 50)
            } else {
                finish()
            }
        } else {
            finish()
        }
    }
}