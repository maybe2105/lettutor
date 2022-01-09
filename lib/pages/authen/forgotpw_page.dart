import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/authen/login_page.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/boilder_plate.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _resetPassKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  Future<bool> sendReset() async {
    try {
      var body = {
        'email': emailController.text,
      };
      var dio = Http().client;
      var res = await dio.post(
        'user/forgotPassword',
        data: body,
      );
      inspect(res);
      return true;
    } catch (e) {
      inspect(e);
      print("Error in reset password");
      return false;
    }
  }

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
      body: Form(
        key: _resetPassKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Reset Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Please enter your email address to search for your account.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  } else if (!EmailValidator.validate(value)) {
                    return "Not a valid email";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (_resetPassKey.currentState!.validate()) {
                    bool result = await sendReset();
                    if (result == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BoilerPlate(
                            page: LoginPage(),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Send reset link',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  primary: Colors.blueAccent, // This is what you need!
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
