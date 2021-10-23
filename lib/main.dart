import 'package:flutter/material.dart';
import 'package:lettutor/pages/authen/forgotpw_page.dart';
import 'package:lettutor/pages/authen/login_page.dart';
import 'package:lettutor/pages/authen/resetpw_page.dart';
import 'package:lettutor/pages/authen/signup_page.dart';
import 'package:lettutor/pages/courses/history_page.dart';
import 'package:lettutor/pages/main/main_page.dart';
import 'package:lettutor/pages/profile/profile_page.dart';
import 'package:lettutor/pages/profile/tutor_detail_page.dart';
import 'package:lettutor/pages/schedule/timetable_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetTutor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.white)
        ),
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),

    );
  }
}

