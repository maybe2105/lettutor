import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            title:  SvgPicture.asset('assets/login_logo.svg',width: 170,height: 40,),
          ),
      body: Center(
        child: ListView(children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Image(
                image: NetworkImage(
                    "https://app.lettutor.com/static/media/login.8d01124a.png"),
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
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32.0, 0, 32, 16),
            child: Text(
                'Become fluent faster through one on one video chat lessons tailored to your goals.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
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
              validator: (val) =>
                  val!.length < 6 ? 'Password too short.' : null,
              onSaved: (val) => _password = val!,
              obscureText: _obscureText,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32,16,32,16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Forgot Password?",style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ElevatedButton(
              onPressed: () => {},
              child: const Text('LOG IN',style: TextStyle(color:Colors.white),),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                primary: Colors.blueAccent, // This is what you need!
              ),
            ),
          ),
          const Center(child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Or continue with",style:TextStyle(fontSize: 16)),
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(32,16,32,16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/facebook_logo.svg',height: 40, width: 40,),
                Container(width: 20, color: Colors.transparent),
                SvgPicture.asset('assets/google_logo.svg',height: 40, width: 40),
                Container(width: 20, color: Colors.transparent),
                SvgPicture.asset('assets/phone_logo.svg',height: 40, width: 40),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
                text: 'Not a member yet? ',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: 'Sign up',
                      style: TextStyle(color: Colors.blue))
                ]),
          ),
          const SizedBox(height: 32),
        ]),
      ),
    ));
  }
}
