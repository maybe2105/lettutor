import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
      body: Column(
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
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(

              onPressed: () => {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Send reset link',style: TextStyle(color:Colors.white),),
              ),
              style: ElevatedButton.styleFrom(

                minimumSize: const Size(100, 40),
                primary: Colors.blueAccent, // This is what you need!
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
