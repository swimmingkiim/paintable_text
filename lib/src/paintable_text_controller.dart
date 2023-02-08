// flutter
import 'package:flutter/material.dart';

// packages
import 'package:vector_math/vector_math.dart';

const TextStyle defaultTextStyle = TextStyle();
const Color defaultTextColor = Color(0xFF000000);
const BoxConstraints defaultCanvasConstraints = BoxConstraints(
  minWidth: 10.0,
  minHeight: 10.0,
  maxWidth: double.infinity,
  maxHeight: double.infinity,
);

class PaintableTextController {
  PaintableTextController({
    BoxConstraints? canvasConstraints,
    String text = '',
    this.onTextChange,
    TextStyle? textStyle,
    Color? color,
    Offset? offset,
  })  : canvasConstraints = canvasConstraints ?? defaultCanvasConstraints,
        color = color ?? defaultTextColor,
        textEditingController = TextEditingController(text: text),
        position = Vector2(offset?.dx ?? 0, offset?.dy ?? 0),
        textStyle = textStyle ?? defaultTextStyle;

  final Vector2 position;

  final TextEditingController textEditingController;
  final void Function(String)? onTextChange;
  final FocusNode focusNode = FocusNode();

  Color color;
  TextStyle textStyle;
  BoxConstraints canvasConstraints;

  bool editing = false;
  bool moving = false;
  Size? textSize;

  String get text => textEditingController.text;

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
            controller: textEditingController,
            onChanged: onTextChange,
            focusNode: focusNode,
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
