// packages
import 'package:vector_math/vector_math.dart' show Vector2;

class EditableTextPosition {
  EditableTextPosition({required this.position});

  final Vector2 position;

  double get x => position.x;

  double get y => position.y;

  set x(double x) => position.x = x;

  set y(double y) => position.y = y;

  void addVector2(Vector2 vector2) => position.add(vector2);
}
