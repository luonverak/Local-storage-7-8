import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(
      {super.key,
      required this.controller,
      required this.hindText,
      this.maxLine});
  var controller = TextEditingController();
  final String hindText;
  var maxLine;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hindText,
      ),
      maxLines: maxLine,
    );
  }
}
