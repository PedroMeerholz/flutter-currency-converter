import 'package:flutter/material.dart';

class CurrencyTextField extends StatelessWidget {
  final String labelText;
  final String prefixText;

  const CurrencyTextField(
      {super.key, required this.labelText, required this.prefixText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.yellow,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        prefixText: prefixText,
      ),
      style: const TextStyle(
        color: Colors.yellow,
        fontSize: 20,
      ),
    );
  }
}
