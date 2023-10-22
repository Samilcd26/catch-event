import 'package:flutter/material.dart';

InputDecoration ITextFieldStyle(
  String labelText,
) {
  return InputDecoration(
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: labelText,
      counterText: "",
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 2),
      ));
}
