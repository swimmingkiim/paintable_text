import 'package:flutter/material.dart';

class EditableTextData {
  EditableTextData({String? text})
      : textEditingController = TextEditingController(text: text);

  TextEditingController textEditingController;
  FocusNode focusNode = FocusNode();

  String get text => textEditingController.text;
}
