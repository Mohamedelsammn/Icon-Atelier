package com.example.iconschange

import android.app.Activity
import android.content.Intent
import android.content.pm.ShortcutManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.os.Build
import android.os.Bundle
import android.content.pm.ShortcutInfo
import android.graphics.drawable.Icon

class ShortcutCreator : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val name = intent.getStringExtra("shortcut_name") ?: return finish()
        val packageName = intent.getStringExtra("shortcut_package") ?: return finish()
        val iconBytes = intent.getByteArrayExtra("shortcut_icon") ?: return finish()

        createShortcut(name, packageName, iconBytes)
        finish()
    }

    private fun createShortcut(name: String, targetPackage: String, iconBytes: ByteArray) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return

        val manager = getSystemService(ShortcutManager::class.java)
        if (!manager.isRequestPinShortcutSupported) return

        val bitmap = BitmapFactory.decodeByteArray(iconBytes, 0, iconBytes.size)
        val finalIcon = buildFinalIcon(bitmap)

        // 🔑 المهم: الاختصار يشير إلى ShortcutActivity (جوه تطبيقنا)
        val shortcutIntent = Intent(this, ShortcutActivity::class.java).apply {
            action = Intent.ACTION_VIEW
            putExtra("target_package", targetPackage)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        val shortcutInfo = ShortcutInfo.Builder(this, "shortcut_${System.currentTimeMillis()}")
            .setShortLabel(name)
            .setLongLabel(name)
            .setIcon(Icon.createWithBitmap(finalIcon))
            .setIntent(shortcutIntent)
            .build()

        // طلب تثبيت الاختصار - هيظهر للمستخدم确认
        manager.requestPinShortcut(shortcutInfo, null)
    }

    private fun buildFinalIcon(main: Bitmap): Bitmap {
        val size = 512
        val output = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(output)
        canvas.drawColor(Color.WHITE)
        val scaledMain = Bitmap.createScaledBitmap(main, size, size, true)
        canvas.drawBitmap(scaledMain, 0f, 0f, Paint(Paint.ANTI_ALIAS_FLAG))
        return output
    }
}