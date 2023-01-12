import 'package:flutter/material.dart';

class RequestMessage extends StatelessWidget {
  final String text;

  RequestMessage({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.yellow, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}