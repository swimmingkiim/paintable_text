// dart
import 'dart:math';

// flutter
import 'package:flutter/material.dart';

// packages
import 'package:collection/collection.dart';

// src
import 'editable_text_controller.dart';
import 'editable_text_painter.dart';

class EditableText extends StatefulWidget {
  const EditableText({Key? key, required this.controllers}) : super(key: key);

  final List<EditableTextController> controllers;

  @override
  State<EditableText> createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableText> {
  EditableTextController? currentController;

  void _down(DragDownDetails details) {
    setState(() {
      currentController = widget.controllers.lastWhereOrNull(
          (controller) => controller.isHover(details.localPosition));
      if (currentController != null) {
        currentController!.moving = true;
      }
    });
  }

  void _up() {
    setState(() {
      if (currentController != null) {
        currentController!.moving = false;
        currentController = null;
      }
    });
  }

  void _move(DragUpdateDetails details) {
    if (currentController != null) {
      setState(() {
        final double x = max(
          0,
          min(
            currentController!.position.x + details.delta.dx,
            currentController!.canvasConstraints.constrainWidth(),
          ),
        );
        final double y = max(
          0,
          min(
            currentController!.position.y + details.delta.dy,
            currentController!.canvasConstraints.constrainHeight(),
          ),
        );
        currentController!.updatePosition(Offset(x, y));
      });
    }
  }

  void _tap(TapUpDetails details) {
    setState(() {
      final EditableTextController? targetController = widget.controllers
          .lastWhereOrNull(
              (controller) => controller.isHover(details.localPosition));
      for (var controller in widget.controllers) {
        if (controller.editing) {
          controller.focusNode.unfocus();
          controller.editing = false;
        }
      }
      targetController?.editing = true;
      currentController?.focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (event) {
        _down(event);
      },
      onPanEnd: (details) {
        _up();
      },
      onPanUpdate: (details) {
        _move(details);
      },
      onTapUp: (TapUpDetails details) {
        _tap(details);
      },
      child: Stack(
        children: widget.controllers
            .map<Widget>((controller) =>
                EditingTextCustomPaintWidget(controller: controller))
            .toList(),
      ),
    );
  }
}

class EditingTextCustomPaintWidget extends StatelessWidget {
  const EditingTextCustomPaintWidget({
    super.key,
    required this.controller,
  });

  final EditableTextController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (controller.editing) controller.textField,
        if (!controller.editing)
          CustomPaint(
            foregroundPainter: EditableTextTextPainter(
              controller: controller,
            ),
            size: Size(
              controller.canvasConstraints.constrainWidth(),
              controller.canvasConstraints.constrainHeight(),
            ),
          ),
      ],
    );
  }
}
