import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late bool _obscureText = true;

  late String _password;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Enter the new password that you would like to use for your account.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    iconSize: 32,
                    icon: _obscureText
                        ? const Icon(MdiIcons.eyeOutline)
                        : const Icon(MdiIcons.eyeOffOutline),
                    onPressed: _toggle,
                  )),
              obscureText: _obscureText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    iconSize: 32,
                    icon: _obscureText
                        ? const Icon(MdiIcons.eyeOutline)
                        : const Icon(MdiIcons.eyeOffOutline),
                    onPressed: _toggle,
                  )),
              obscureText: _obscureText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () => {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Submit',
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
    ));
  }
}
