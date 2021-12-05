import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/models/tutor_dto.dart';
import 'package:lettutor/widgets/tutorcard_nofavorite_widget.dart';
import 'package:lettutor/widgets/tutorcard_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TutorDTO> tutors = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString("assets/tutor.json");
    Iterable i = jsonDecode(jsonText);
    List<TutorDTO>? result =
    List<TutorDTO>.from(i.map((tutor) => TutorDTO.fromJson(tutor)));
    setState(() {
      if (result == null) {
        tutors = [];
      } else {
        tutors = result;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home",style: TextStyle(
          color:Colors.black,
          fontSize:16,
        ),),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.indigoAccent,
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Welcome to LetTutor",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      child: const Text(
                        "Book a lesson?",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
          ///////////////////////////////////////////
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              "Recommended",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          ListView(
            shrinkWrap: true,
            primary: false,
            children: tutors
                .map((tutor) => TutorCardWidget(tutorData: tutor))
                .toList(),
          ),
        ],
      ),
    );
  }
}
