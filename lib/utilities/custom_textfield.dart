import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final Color cursorColor;
  final Color placeholderColor;
  final Color focusedOutlineBorder;
  final bool isPassword;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Color textColor;

  final int minLines;
  final int maxLines;

  CustomTextField({
    @required this.placeholder,
    this.cursorColor = Colors.deepPurpleAccent,
    this.placeholderColor = Colors.deepPurpleAccent,
    this.focusedOutlineBorder = Colors.deepPurpleAccent,
    this.onChanged,
    this.isPassword = false,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.controller,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: this.minLines,
      maxLines: this.maxLines,
      obscureText: this.isPassword,
      cursorColor: this.cursorColor,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: this.placeholder,
        hasFloatingPlaceholder: true,
        labelStyle: TextStyle(
          color: this.placeholderColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPurpleColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: this.focusedOutlineBorder,
          ),
        ),
      ),
      onChanged: this.onChanged,
      controller: this.controller,

    );
  }
}