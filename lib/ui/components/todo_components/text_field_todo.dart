import 'package:flutter/material.dart';

class TextFieldTodo extends StatelessWidget {
  final String label;
  final void Function(String) onTextFieldSubmitted;

  TextFieldTodo({
    super.key,
    required this.label,
    required this.onTextFieldSubmitted,
  });

  final TextEditingController _todoTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: TextField(
        controller: _todoTextFieldController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        onSubmitted: (String value) {
          // ignore: avoid_print
          onTextFieldSubmitted(value);
          _todoTextFieldController.clear();
        },
      ),
    );
  }
}
