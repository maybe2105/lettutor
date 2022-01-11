import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/pages/authen/login_page.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/boilder_plate.dart';
import 'package:lettutor/widgets/tutorcard_nofavorite_widget.dart';
import 'package:lettutor/widgets/tutorcard_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tutor> tutors = [];

  void initState() {
    super.initState();
    getFavoriteTutor();
    getTotalTime();
  }
  double totalLearntTime = 0;

  Future<void> getTotalTime() async {
    var accessToken = Provider.of<AuthProvider>(context, listen: false)
        .auth
        .tokens!
        .access!
        .token;
    var dio = Http().client;
    dio.options.headers["Authorization"] = "Bearer $accessToken";
    var res = await dio.get("call/total");
    setState(() {
      totalLearntTime = res.data["total"].toDouble() ?? 0;
    });
  }

  void getFavoriteTutor() {
    try {
      var dio = Http().client;
      var query = {
        'perPage': '1',
        'page': '1',
      };
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
        var accessToken = Provider.of<AuthProvider>(context, listen: false)
            .auth
            .tokens!
            .access!
            .token;
        dio.options.headers["Authorization"] = "Bearer $accessToken";
        var res = await dio.get(
          "tutor/more",
          queryParameters: query,
        );
        Iterable i = res.data["favoriteTutor"];
        List<Tutor>? result = List<Tutor>.from(
          await Future.wait(
            i.map(
                  (tutor) async {
                if (tutor["secondInfo"] != null) {
                  String id = tutor["secondId"];
                  var tutorRes = await dio.get("tutor/$id");
                  var detail = tutorRes.data;
                  var data = Tutor.fromJson(detail);
                  return data;
                } else {
                  return Tutor();
                }
              },
            ),
          ),
        ).where((element) => element.id != null).toList();
        setState(() {
          tutors = result;
        });
      });
    } catch (e) {
      inspect(e);
    }
  }


  // Future<void> loadJsonData() async {
  //   var jsonText = await rootBundle.loadString("assets/tutor.json");
  //   Iterable i = jsonDecode(jsonText);
  //   List<Tutor>? result =
  //   List<Tutor>.from(i.map((tutor) => Tutor.fromJson(tutor)));
  //   setState(() {
  //     if (result == null) {
  //       tutors = [];
  //     } else {
  //       tutors = result;
  //     }
  //   });
  // }
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
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                      "Total lesson time is " +
                            (totalLearntTime / 60).floor().toString() + " hours " +
                            (totalLearntTime.round() % 60).toString() + " minutes",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {

                      },
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
                .map((tutor) => TutorCardWidget(tutorData: tutor,booking: true,))
                .toList(),
          ),
        ],
      ),
    );
  }
}
