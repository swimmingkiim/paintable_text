// flutter
import 'package:flutter/material.dart';

class EditableTextCaret {
  EditableTextCaret({required this.offset});

  bool editing = false;
  Offset offset;

  void startEditing() => editing = true;

  void endEditing() => editing = false;

  void updateOffset(Offset offset) => this.offset = offset;
}
