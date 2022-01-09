import 'dart:convert';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/avatar_widget.dart';
import 'package:lettutor/widgets/primary_button_rounded.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';
import 'package:lettutor/widgets/teacher_infomation.dart';
import 'package:lettutor/widgets/tutor_info.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime selectedDate = DateTime.now();
  var countryName = 'Vietnam';
  User? user;
  bool? loading = false;
  Future<void> getUserDetail() async {
    try {
      setState(() {
        loading = true;
      });
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false)
          .auth
          .tokens!
          .access!
          .token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get("user/info");
      setState(() {
        user = User.fromJson(res.data["user"]);
        loading = false;
      });
    } catch (e) {
      inspect(e);
      setState(() {
        loading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final List<String> levelItems = ['Beginer', 'Intermediate', 'Advanced'];
  var level = 'Beginer';

  final List<String> categories = ['TOEIC', 'TOEFL', 'IELTS', 'PET', 'KET', 'FLYERS'];
  var wantToLearn = 'IELTS';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body:  user == null || loading == true
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: Column(
            children: [
              AvatarBlock(
                user: user ?? User(),
                onUpdateInfo: () async {
                  await getUserDetail();
                },
              ),

              TeacherInfomation(
                user: user!,
                onUpdateInfo: () {
                  getUserDetail();
                },
              ),

              user!.tutorInfo == null
                  ? Container()
                  : TutorInformation(
                user: user!,
                onUpdateInfo: () {
                  getUserDetail();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
