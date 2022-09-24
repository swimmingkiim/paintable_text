class EditableTextData {
  EditableTextData({this.textData = ''});

  bool editing = false;
  String textData;

  void startEditing() => editing = true;

  void endEditing() => editing = false;

  void updateTextData(String text) => textData = text;
}
