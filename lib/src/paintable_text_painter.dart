// flutter
import 'package:flutter/material.dart';

// src
import 'paintable_text_controller.dart';

class PaintableTextTextPainter extends CustomPainter {
  PaintableTextTextPainter({
    required this.controller,
  });

  final PaintableTextController controller;

  TextPainter textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: controller.text,
      style: controller.textStyle,
    );
    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();

    controller.textSize = textPainter.size;

    final offset = Offset(
      controller.position.x,
      controller.position.y,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(PaintableTextTextPainter oldDelegate) {
    if (!controller.moving && !controller.editing) {
      return false;
    }
    return true;
  }

  @override
  bool? hitTest(Offset position) {
    return true;
  }
}
