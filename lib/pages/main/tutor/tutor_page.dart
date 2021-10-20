import 'package:flutter/material.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutor",style: TextStyle(
          color:Colors.black,
          fontSize:16,
        ),),
        backgroundColor: Colors.white,
      ),
    );
  }
}
