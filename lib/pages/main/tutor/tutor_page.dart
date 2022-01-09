import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/taglist_widget.dart';
import 'package:lettutor/widgets/tutorcard_nofavorite_widget.dart';
import 'package:lettutor/widgets/tutorcard_widget.dart';
import 'package:lettutor/widgets/tutortag_widget.dart';
import 'package:provider/provider.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  List<Tutor> tutors = [];
  int count = 0;
  int perPage = 5;
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getTutors();
  }

  var tagsList = [
    "business-english",
    "conversational-english",
    "english-for-kids",
    "ielts",
    "toeic",
    "starters",
    "movers",
    "flyers",
    "ket",
    "pet",
    "toefl"
  ];

  void getTutors() {
    try {
      setState(() {
        loading = true;
      });
      var dio = Http().client;
      var query = {
        'perPage': perPage.toString(),
        'page': page.toString(),
      };
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
        var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
        dio.options.headers["Authorization"] = "Bearer $accessToken";
        var res = await dio.get(
          "tutor/more",
          queryParameters: query,
        );
        Iterable favIter = res.data["favoriteTutor"];
        List<Tutor> favTutors = List<Tutor>.from(
          await Future.wait(
            favIter.map(
              (tutor) async {
                String id = tutor["secondId"];
                var tutorRes = await dio.get("tutor/$id");
                var detail = tutorRes.data;
                var data = Tutor.fromJson(detail);
                return data;
              },
            ),
          ),
        );
        Iterable iter = res.data["tutors"]["rows"];
        List<Tutor> paginatedData = List<Tutor>.from(iter.map((tutor) => Tutor.fromJson(tutor)));
        paginatedData = paginatedData.map((element) {
          if (favTutors.any((favTutor) => favTutor.user?.email == element.email)) {
            element.isFavorite = true;
          }
          return element;
        }).toList();
        setState(() {
          tutors.addAll(paginatedData);
          count = res.data["tutors"]["count"];
          loading = false;
        });
      });
    } catch (e) {
      inspect(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    inspect(tutors);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tutor",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Type to search",
                    prefixIcon: GestureDetector(
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: TagsList(
                  tagsList: tagsList,
                  isHorizontal: true,
                ),
                padding: EdgeInsets.only(bottom: 10),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  child: Column(
                    children: [
                      tutors.isNotEmpty
                          ? ListView(
                              shrinkWrap: true,
                              primary: false,
                              children: tutors
                                  .map(
                                    (tutor) => TutorCardWidget(
                                      tutorData: tutor,
                                      ),
                                  )
                                  .toList(),
                            )
                          : loading == true
                              ? Container()
                              : Container(
                                  child: Text(
                                    "No data",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 20),
                                ),
                      perPage * page < count
                          ? Container(
                              child: CustomizedButton(
                                btnText: "Load more",
                                onTap: () {
                                  setState(() {
                                    page = page + 1;
                                  });
                                  getTutors();
                                },
                                hasBorder: false,
                                textSize: 20,
                              ),
                              margin: EdgeInsets.only(
                                top: 16,
                                bottom: 4,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              loading == true
                  ? Container(
                      child: CircularProgressIndicator(),
                      padding: EdgeInsets.only(top: 20),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
