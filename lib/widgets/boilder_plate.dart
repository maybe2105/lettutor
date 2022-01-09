import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:provider/provider.dart';

class BoilerPlate extends StatefulWidget {
  const BoilerPlate({Key? key, required this.page}) : super(key: key);
  final Widget page;
  @override
  _BoilerPlateState createState() => _BoilerPlateState();
}

class _BoilerPlateState extends State<BoilerPlate> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LetTutor',

          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
          /*REPLACE THIS TO VISIT OTHER SCREEN, CLASS NAME OF THE FILES IN /lib/screens IS SCREEN NAMES */
          home: widget.page,
          /*REPLACE THIS TO VISIT OTHER SCREEN, CLASS NAME OF THE FILES IN /lib/screens IS SCREEN NAMES */
        );
      },
    );
  }
}
