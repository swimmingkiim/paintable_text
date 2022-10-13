# editable_text_painter
This package provides advanced TextPainter with features like dragging text and editing text.

![example_demo](https://github.com/swimmingkiim/editable_text_painter/blob/main/screenshots/example_demo.gif?raw=true)

## Features

- Change TextStyle
- Drag text
- Edit text
- Set initial position of text

## Getting started

### Install package
```bash
flutter pub add editable_text_painter
```

No other prerequisites required

## Usage

```dart
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

```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
