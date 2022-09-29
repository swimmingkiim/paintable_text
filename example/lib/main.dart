// flutter
import 'package:flutter/material.dart';

// packages
import 'package:editable_text/editable_text.dart' as editable_text;

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
      home: const EditableTextExample(),
    );
  }
}

class EditableTextExample extends StatefulWidget {
  const EditableTextExample({super.key});

  @override
  State<EditableTextExample> createState() => _EditableTextExampleState();
}

class _EditableTextExampleState extends State<EditableTextExample> {
  final editable_text.EditableTextController controller1 =
      editable_text.EditableTextController(
    text: 'text_1',
    textStyle: const TextStyle(
      color: Colors.red,
    ),
    offset: const Offset(100.0, 100.0),
  );

  final editable_text.EditableTextController controller2 =
      editable_text.EditableTextController(
    text: 'text_2',
    textStyle: const TextStyle(
      color: Colors.blue,
    ),
    offset: const Offset(200.0, 200.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return editable_text.EditableText(controllers: [
          controller1..canvasConstraints = constraints,
          controller2..canvasConstraints = constraints,
        ]);
      }),
    );
  }
}
