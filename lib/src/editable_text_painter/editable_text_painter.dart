// flutter
import 'package:flutter/material.dart';

// src
import 'package:editable_text_painter/src/editable_text_controller/editable_text_controller.dart';

class EditableTextTextPainter extends CustomPainter {
  EditableTextTextPainter({
    required this.controller,
  });

  final EditableTextController controller;

  TextPainter textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: controller.data.text,
      style: controller.textStyle,
    );
    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: controller.canvasConstraints.minWidth,
      maxWidth: controller.canvasConstraints.maxWidth,
    );

    controller.textSize = textPainter.size;

    final offset = Offset(
      controller.position.x,
      controller.position.y,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(EditableTextTextPainter oldDelegate) {
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
