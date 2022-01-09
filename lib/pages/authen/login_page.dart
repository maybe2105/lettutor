import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/pages/authen/login_form.dart';
import 'package:lettutor/pages/authen/signup_page.dart';
import 'package:lettutor/pages/main/main_page.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/boilder_plate.dart';
import 'package:lettutor/widgets/sumit_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/login_logo.svg',
          width: 170,
          height: 40,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Image(
                  image: NetworkImage("https://app.lettutor.com/static/media/login.8d01124a.png"),
                  semanticLabel: "LetTutor Banner",
                  width: 300,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: Text(
                  "Start learning with LetTutor",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32.0, 0, 32, 16),
              child: Text('Become fluent faster through one on one video chat lessons tailored to your goals.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            ),
            LoginForm(),
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Or continue with", style: TextStyle(fontSize: 16)),
            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/facebook_logo.svg',
                    height: 40,
                    width: 40,
                  ),
                  Container(width: 20, color: Colors.transparent),
                  SvgPicture.asset('assets/google_logo.svg', height: 40, width: 40),
                  Container(width: 20, color: Colors.transparent),
                  SvgPicture.asset('assets/phone_logo.svg', height: 40, width: 40),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(

              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Not a member yet?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                     "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff2862d2),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BoilerPlate(
                      page: SignupPage(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ]),
        ),
      ),
    ));
  }
}
