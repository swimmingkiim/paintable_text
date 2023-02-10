// flutter
import 'package:flutter/material.dart';

// packages
import 'package:paintable_text/paintable_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo for PaintableTextPainter Canvas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaintableTextExample(),
    );
  }
}

class PaintableTextExample extends StatefulWidget {
  const PaintableTextExample({super.key});

  @override
  State<PaintableTextExample> createState() => _PaintableTextExampleState();
}

class _PaintableTextExampleState extends State<PaintableTextExample> {
  final PaintableTextController controller1 = PaintableTextController(
    text: 'text_1',
    textStyle: const TextStyle(
      color: Colors.red,
      fontSize: 20.0,
    ),
    offset: const Offset(100.0, 100.0),
  );

  final PaintableTextController controller2 = PaintableTextController(
    text: 'text_2',
    textStyle: const TextStyle(
      color: Colors.blue,
      fontSize: 20.0,
    ),
    offset: const Offset(200.0, 200.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500.0,
        height: 500.0,
        color: Colors.red,
        child: LayoutBuilder(builder: (context, constraints) {
          return PaintableText(controllers: [
            controller1..canvasConstraints = constraints,
            controller2..canvasConstraints = constraints,
          ]);
        }),
      ),
    );
  }
}
