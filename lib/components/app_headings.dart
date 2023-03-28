import 'package:flutter/material.dart';

class TextSemiBold extends StatelessWidget {
  final String text;

  const TextSemiBold({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Color(0xff114C3A),
          fontSize: 24.0,
          fontWeight: FontWeight.w600),
    );
  }
}
