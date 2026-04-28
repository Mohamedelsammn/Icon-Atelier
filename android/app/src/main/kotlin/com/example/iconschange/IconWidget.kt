package com.example.iconschange

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.app.PendingIntent
import android.graphics.BitmapFactory
import android.util.Base64
import android.widget.RemoteViews

class IconWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (id in appWidgetIds) {
            updateWidget(context, appWidgetManager, id)
        }
    }

    companion object {
        fun updateWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            widgetId: Int
        ) {
            val prefs = context.getSharedPreferences("widget_prefs", Context.MODE_PRIVATE)

            // ✅ بنقرأ last_icon و last_package مباشرة
            val iconBase64 = prefs.getString("last_icon", null)
            val packageName = prefs.getString("last_package", null)

            val views = RemoteViews(context.packageName, R.layout.widget_icon)

            if (iconBase64 != null) {
                val bytes = Base64.decode(iconBase64, Base64.DEFAULT)
                val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                views.setImageViewBitmap(R.id.widget_icon, bitmap)
            }

            if (packageName != null) {
                val launchIntent = context.packageManager.getLaunchIntentForPackage(packageName)
                if (launchIntent != null) {
                    val pendingIntent = PendingIntent.getActivity(
                        context, widgetId, launchIntent,
                        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                    )
                    views.setOnClickPendingIntent(R.id.widget_icon, pendingIntent)
                }
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}