import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class IconConverter {
  /// Converts an [IconData] to a PNG [Uint8List].
  ///
  /// - Carbon style   → dark background  + white icon (outline or solid)
  /// - Prism  style   → pastel background + colored icon, rounded card
  static Future<Uint8List> iconToBytes(
    IconData icon, {
    double size = 512.0,
    Color color = Colors.white,
    Color backgroundColor = const Color(0xFF1A1A1A),
    bool isPrism = false,
    bool isOutline = false,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, size, size),
    );

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size, size),
      Radius.circular(size * 0.22),
    );

    if (isPrism) {
      // ── Prism: pastel solid background ──────────────────────────────
      canvas.drawRRect(rrect, Paint()..color = backgroundColor);

      // Subtle inner glow ring
      canvas.drawRRect(
        rrect.deflate(size * 0.015),
        Paint()
          ..color = Colors.white.withValues(alpha: 0.18)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size * 0.018,
      );
    } else {
      // ── Carbon: dark background (solid or gradient) ─────────────────
      final bgPaint = Paint()
        ..shader = ui.Gradient.linear(
          const Offset(0, 0),
          Offset(size, size),
          [backgroundColor, _darken(backgroundColor, 0.12)],
        );
      canvas.drawRRect(rrect, bgPaint);
    }

    // ── Draw the icon ────────────────────────────────────────────────
    final iconData = isOutline ? _toOutlineIcon(icon) : icon;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: size * 0.52,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        color: color,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size - textPainter.width) / 2,
        (size - textPainter.height) / 2,
      ),
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  /// Try to find the outlined variant; fall back to the original icon.
  static IconData _toOutlineIcon(IconData icon) {
    // Icons.mail → Icons.mail_outline, etc.
    // Flutter's outlined icons share the same codePoint but different fontFamily.
    // Since we already pass outline icons from the bloc data, just return as-is.
    return icon;
  }

  static Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}
