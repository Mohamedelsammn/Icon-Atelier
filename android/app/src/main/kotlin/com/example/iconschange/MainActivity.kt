package com.example.iconschange

import android.content.Intent
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity : FlutterActivity() {

    private val CHANNEL = "apps_channel"
    private val REQUEST_PIN_SHORTCUT = 1001

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getApps" -> result.success(getInstalledApps())
                    "createShortcut" -> {
                        val name = call.argument<String>("name") ?: return@setMethodCallHandler
                        val packageName = call.argument<String>("package") ?: return@setMethodCallHandler
                        val iconBytes = call.argument<ByteArray>("icon") ?: return@setMethodCallHandler
                        createShortcut(name, packageName, iconBytes)
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getInstalledApps(): List<Map<String, Any>> {
        val pm = packageManager
        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)
        val apps = pm.queryIntentActivities(intent, 0)

        return apps.mapNotNull { app ->
            try {
                val appInfo = app.activityInfo.applicationInfo
                val drawable = pm.getApplicationIcon(appInfo)
                val bitmap = drawableToBitmap(drawable)
                val stream = ByteArrayOutputStream()
                Bitmap.createScaledBitmap(bitmap, 128, 128, true)
                    .compress(Bitmap.CompressFormat.PNG, 100, stream)
                mapOf(
                    "name" to pm.getApplicationLabel(appInfo).toString(),
                    "package" to appInfo.packageName,
                    "icon" to stream.toByteArray().toList()
                )
            } catch (e: Exception) {
                null
            }
        }
    }

    private fun createShortcut(name: String, packageName: String, iconBytes: ByteArray) {
        val intent = Intent(this, ShortcutCreator::class.java).apply {
            putExtra("shortcut_name", name)
            putExtra("shortcut_package", packageName)
            putExtra("shortcut_icon", iconBytes)
        }
        startActivity(intent)
    }

    private fun drawableToBitmap(drawable: Drawable): Bitmap {
        if (drawable is BitmapDrawable) return drawable.bitmap
        val bitmap = Bitmap.createBitmap(
            drawable.intrinsicWidth.coerceAtLeast(1),
            drawable.intrinsicHeight.coerceAtLeast(1),
            Bitmap.Config.ARGB_8888
        )
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }
}