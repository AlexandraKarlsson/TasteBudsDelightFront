import 'package:flutter/material.dart';

const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

InputDecoration defaultTextFieldDecoration(String text) {
  return InputDecoration(
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      border: OutlineInputBorder(),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white));
}
