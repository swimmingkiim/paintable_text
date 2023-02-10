// dart
import 'dart:math';

// flutter
import 'package:flutter/material.dart';

// packages
import 'package:collection/collection.dart';

// src
import 'paintable_text_controller.dart';
import 'paintable_text_painter.dart';

class PaintableText extends StatefulWidget {
  const PaintableText({
    Key? key,
    required this.controllers,
    required this.constraints,
  }) : super(key: key);

  final List<PaintableTextController> controllers;
  final BoxConstraints constraints;

  @override
  State<PaintableText> createState() => _PaintableTextState();
}

class _PaintableTextState extends State<PaintableText> {
  PaintableTextController? currentController;

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
            currentController!.canvasConstraints.maxWidth -
                currentController!.textSize!.width,
          ),
        );
        final double y = max(
          0,
          min(
            currentController!.position.y + details.delta.dy,
            currentController!.canvasConstraints.maxHeight -
                currentController!.textSize!.height,
          ),
        );
        currentController!.updatePosition(Offset(x, y));
      });
    }
  }

  void _tap(TapUpDetails details) {
    setState(() {
      final PaintableTextController? targetController = widget.controllers
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
      onTap: () {},
      onTapUp: (TapUpDetails details) {
        _tap(details);
      },
      child: Stack(
        children: [
          Container(
            width: widget.constraints.maxWidth,
            height: widget.constraints.maxHeight,
            color: Colors.transparent,
          ),
          ...widget.controllers
              .map<Widget>((controller) =>
                  PaintableTextCustomPaintWidget(controller: controller))
              .toList(),
        ],
      ),
    );
  }
}

class PaintableTextCustomPaintWidget extends StatelessWidget {
  const PaintableTextCustomPaintWidget({
    super.key,
    required this.controller,
  });

  final PaintableTextController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (controller.editing) controller.textField,
        if (!controller.editing)
          CustomPaint(
            foregroundPainter: PaintableTextTextPainter(
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
