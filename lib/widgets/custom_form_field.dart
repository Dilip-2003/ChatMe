import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final RegExp validationRegExp;
  final bool obscureText;
  final void Function(String?) onSaved;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.height,
    required this.validationRegExp,
    required this.onSaved,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) {
        if (value != null && validationRegExp.hasMatch(value)) {
          return null;
        }
        return 'Enter a valid ${hintText.toLowerCase()}';
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      obscureText: obscureText,
    );
  }
}
