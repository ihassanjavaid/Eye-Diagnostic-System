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

  // directly passed colors because const field required in optional parameter
  CustomTextField({
    @required this.placeholder,
    this.cursorColor = const Color(0xFFedf5f4),
    this.placeholderColor = const Color(0xFFedf5f4),
    this.focusedOutlineBorder = const Color(0xFFedf5f4),
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
        labelStyle: kCustomInputLabelStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kTealColor,
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