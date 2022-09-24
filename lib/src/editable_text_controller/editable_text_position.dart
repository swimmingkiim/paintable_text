// packages
import 'package:vector_math/vector_math.dart' show Vector2;

class EditableTextPosition {
  EditableTextPosition({required this.position});

  bool moving = false;
  final Vector2 position;

  void startMoving() => moving = true;

  void endMoving() => moving = false;

  void addVector2(Vector2 vector2) => position.add(vector2);
}
