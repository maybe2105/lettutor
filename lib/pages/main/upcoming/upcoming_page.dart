import 'package:flutter/material.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting",style: TextStyle(
          color:Colors.black,
          fontSize:16,
        ),),
        backgroundColor: Colors.white,
      ),
      body: Container(),
    );
  }
}
