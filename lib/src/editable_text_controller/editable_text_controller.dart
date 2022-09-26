// flutter
import 'package:flutter/material.dart';

// packages
import 'package:vector_math/vector_math.dart';

// src
import 'package:editable_text_painter/src/editable_text_controller/editable_text_data.dart';
import 'package:editable_text_painter/src/editable_text_controller/editable_text_position.dart';

const TextStyle defaultTextStyle = TextStyle();
const Color defaultTextColor = Color(0xFF000000);
const BoxConstraints defaultCanvasConstraints = BoxConstraints(
  minWidth: 10.0,
  minHeight: 10.0,
  maxWidth: double.infinity,
  maxHeight: double.infinity,
);

class EditableTextController {
  EditableTextController({
    BoxConstraints? canvasConstraints,
    String text = '',
    TextStyle? textStyle,
    Color? color,
  })  : canvasConstraints = canvasConstraints ?? defaultCanvasConstraints,
        color = color ?? defaultTextColor,
        data = EditableTextData(text: text),
        position = EditableTextPosition(position: Vector2.zero()),
        textStyle = textStyle ?? defaultTextStyle;

  final EditableTextData data;
  final EditableTextPosition position;

  Color color;
  TextStyle textStyle;
  BoxConstraints canvasConstraints;

  bool editing = false;
  bool moving = false;
  Size? textSize;

  Rect get rect {
    if (textSize == null) {
      return Rect.zero;
    }
    return Rect.fromPoints(
      Offset(position.x + textSize!.width + 2, position.y),
      Offset(position.x + textSize!.width + 5, position.y + textSize!.height),
    );
  }

  Widget get textField {
    return Positioned(
      top: position.y,
      left: position.x,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: textSize!.width,
          minHeight: textSize!.height,
        ),
        child: IntrinsicWidth(
          child: TextField(
            controller: data.textEditingController,
            focusNode: data.focusNode,
            maxLines: null,
            scrollPadding: const EdgeInsets.all(0.0),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: textStyle,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }

  bool isHover(Offset offset) {
    if (textSize == null) {
      return false;
    }
    final double x = offset.dx;
    final double y = offset.dy;
    return x >= position.x &&
        y >= position.y &&
        x <= position.x + textSize!.width &&
        y <= position.y + textSize!.height;
  }

  void updatePosition(Offset offset) {
    position.x = offset.dx;
    position.y = offset.dy;
  }
}
