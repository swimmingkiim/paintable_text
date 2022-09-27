// dart
import 'dart:math';

// flutter
import 'package:flutter/material.dart';

// packages
import 'package:editable_text_painter/editable_text_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo for EditableTextPainter Canvas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EditableTextPainterExample(
          title: 'Flutter Demo for EditableTextPainter Canvas'),
    );
  }
}

class EditableTextPainterExample extends StatefulWidget {
  const EditableTextPainterExample({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<EditableTextPainterExample> createState() =>
      _EditableTextPainterExampleState();
}

class _EditableTextPainterExampleState
    extends State<EditableTextPainterExample> {
  final EditableTextController controller = EditableTextController(
    text: 'hello world!',
    textStyle: const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    offset: const Offset(100.0, 100.0),
  );

  void _down(DragDownDetails details) {
    setState(() {
      if (controller.isHover(details.localPosition)) {
        controller.moving = true;
      } else {
        controller.moving = false;
      }
    });
  }

  void _up() {
    setState(() {
      controller.moving = false;
    });
  }

  void _move(DragUpdateDetails details, BoxConstraints constraints) {
    if (controller.moving) {
      setState(() {
        final double x = max(
          0,
          min(
            controller.position.x + details.delta.dx,
            controller.canvasConstraints.constrainWidth(),
          ),
        );
        final double y = max(
          0,
          min(
            controller.position.y + details.delta.dy,
            controller.canvasConstraints.constrainHeight(),
          ),
        );
        controller.updatePosition(Offset(x, y));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanDown: (event) {
              _down(event);
            },
            onPanEnd: (details) {
              _up();
            },
            onPanUpdate: (details) {
              _move(details, constraints);
            },
            onTapUp: (TapUpDetails details) {
              setState(() {
                if (controller.isHover(details.localPosition)) {
                  controller.editing = true;
                  controller.focusNode.requestFocus();
                } else {
                  controller.focusNode.unfocus();
                  controller.editing = false;
                }
              });
            },
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.grey,
              child: Stack(
                children: [
                  if (controller.editing) controller.textField,
                  if (!controller.editing)
                    CustomPaint(
                      foregroundPainter: EditableTextTextPainter(
                        controller: controller..canvasConstraints = constraints,
                      ),
                      size: Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
