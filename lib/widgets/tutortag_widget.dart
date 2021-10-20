import 'package:flutter/material.dart';

class TutorTag extends StatefulWidget {
  const TutorTag({Key? key, required this.content}) : super(key: key);

  final String content;

  @override
  _TutorTagState createState() => _TutorTagState();
}

class _TutorTagState extends State<TutorTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(32),
        color: Colors.black12
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(widget.content),
      ),
    );
  }
}
