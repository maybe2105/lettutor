import 'package:flutter/material.dart';

class TutorCardTag extends StatelessWidget {
  const TutorCardTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: const BorderRadius.all(
            Radius.circular(16.0) //                 <--- border radius here
            ),
      ),
      child: const Text(
        "tag",
        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
      ),
    );
  }
}
