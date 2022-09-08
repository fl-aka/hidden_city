import 'package:flutter/material.dart';
import 'package:hidden_city/utils/testing/chatp/codeglass.dart';

class TextBot extends StatefulWidget {
  const TextBot({super.key});

  @override
  State<TextBot> createState() => _TextBotState();
}

class _TextBotState extends State<TextBot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const GlassMaji(size: 30),
    );
  }
}
