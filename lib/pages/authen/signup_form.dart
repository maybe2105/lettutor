import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/pages/main/home/home_page.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/boilder_plate.dart';
import 'package:lettutor/widgets/sumit_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  late bool _obscureText = true;

  late String _password;
  late String? errorConfirm = "";

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<bool> signUp() async {
    try {
      var body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var dio = Http().client;
      var res = await dio.post(
        'auth/register',
        data: body,
      );
      inspect(res);
      return true;
    } catch (e) {
      inspect(e);
      print("Error in sign up");
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key:_signUpFormKey,
      child: Column(
        children: [

           Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1),
                ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1),
                  ),
                  suffixIcon: IconButton(
                    iconSize: 25,
                    icon: _obscureText
                        ? const Icon( Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: _toggle,
                  )),
              validator: (val) =>
              val!.length < 6 ? 'Password too short.' : null,
              obscureText: _obscureText,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 0),
            child: TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1),
                ),
                labelText: "Confirm Password",
                errorText: errorConfirm != "" ? errorConfirm : null,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _obscureText,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    errorConfirm = "Required";
                  });
                } else if (value != passwordController.text) {
                  setState(() {
                    errorConfirm = "Input not match with current password";
                  });
                } else {
                  setState(() {
                    errorConfirm = null;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 16,),
          Container(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 24),
            child: SubmitButton(
              btnText: "Sign Up",
              onTap: () async {
                if (_signUpFormKey.currentState!.validate()) {
                  bool result = await signUp();
                  if (result == true) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BoilerPlate(
                          page: HomePage(),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
