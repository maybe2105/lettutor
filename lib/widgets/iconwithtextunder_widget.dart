import 'package:flutter/material.dart';

class IconWithTextUnder extends StatelessWidget {
  const IconWithTextUnder({Key? key, required this.icon, required this.text}) : super(key: key);

  final IconData icon;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blueAccent,
        ),
        Text(text, style: const TextStyle(color: Colors.blueAccent))
      ],
    );
  }
}
