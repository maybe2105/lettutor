import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/pages/authen/forgotpw_page.dart';
import 'package:lettutor/pages/authen/login_form.dart';
import 'package:lettutor/pages/main/main_page.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/boilder_plate.dart';
import 'package:lettutor/widgets/sumit_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late bool _obscureText = true;

  late String _password;

  late String? _error = "";

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController =
  TextEditingController(text: 'student@lettutor.com');
  TextEditingController passwordController =
  TextEditingController(text: '123456');
  Future<Auth?> login() async {
    try {
      var body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var dio = Http().client;
      var res = await dio.post(
        'auth/login',
        data: body,
      );
      var auth = Auth.fromJson(res.data);
      inspect(auth);
      var accessToken = auth.tokens!.access!.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var resInfo = await dio.get("user/info");
      auth.user = User.fromJson(resInfo.data["user"]);
      inspect(auth);
      return auth;
    } on DioError  catch (e) {
      inspect(e);
      setState(() {
        _error = e.response?.data["message"];
      });


      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 1),
                  ),
                  labelText: "Email",
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
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
              child: TextFormField(
                controller: passwordController,

                decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _error != "" ? _error : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      iconSize: 32,
                      icon: _obscureText ? const Icon(MdiIcons.eyeOutline) : const Icon(MdiIcons.eyeOffOutline),
                      onPressed: _toggle,
                    )),

                validator: (val) => val!.length < 6 ? 'Password too short.' : null,

                obscureText: _obscureText,
              ),
            ),
             Padding(
              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BoilerPlate(
                          page: ForgotPassword(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),

              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  return SubmitButton(
                    btnText: "Login",
                    onTap: () async {
                      if (_signInFormKey.currentState!.validate()) {
                        Auth? result = await login();
                        if (result != null) {
                          value.setAuth(result);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const BoilerPlate(
                                page: MainPage(),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
