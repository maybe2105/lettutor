import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/models/user_dto.dart';
import 'package:lettutor/pages/courses/courses_page.dart';
import 'package:lettutor/pages/courses/history_page.dart';
import 'package:lettutor/pages/courses/session_history_page.darr.dart';
import 'package:lettutor/pages/profile/become_tutor.dart';
import 'package:lettutor/pages/profile/profile_page.dart';
import 'package:lettutor/widgets/fullscreen_dialog_widget.dart';
import 'package:lettutor/widgets/settingitem_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  UserDTO? user;

  displayDialog(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            FullScreenDialog(title: title, content: content),
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString("assets/user.json");
    Map<String, dynamic> mapper = jsonDecode(jsonText);
    UserDTO result = UserDTO.fromJson(mapper);
    setState(() {
      user = result;
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                child: Row(
                  children: [
                     Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 16),
                      child: Image(
                        image: NetworkImage(user?.avatar ?? "https://previews.123rf.com/images/latkun/latkun1712/latkun171200130/92172856-empty-transparent-background-seamless-pattern.jpg"),
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          user?.name ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user?.email ?? "")
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SettingItem(
                icon: Icons.person,
                text: "View Feedbacks",
                onClick: () {},
              ),
              SettingItem(
                icon: Icons.menu,
                text: "Booking",
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StudentBookingHistoryPage()),
                  );
                },
              ),
              SettingItem(
                icon: Icons.history,
                text: "Session",
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SessionHistoryPage()),
                  );
                },
              ),
              SettingItem(
                icon: MdiIcons.school,
                text: "Courses",
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CoursesPage()),
                  );
                },
              ),
              SettingItem(
                icon: Icons.settings,
                text: "Advanced Settings",
                onClick: () {
                  displayDialog(
                    context,
                    "Become A Tutor",
                    const BecomeTutorPage(),
                  );
                },
              ),
              const SizedBox(
                height: 28,
              ),
              SettingItem(
                icon: MdiIcons.web,
                text: "Our website",
                onClick: () {},
              ),
              SettingItem(
                icon: Icons.facebook_outlined,
                text: "Facebook",
                onClick: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Version 1.0",
                  textAlign: TextAlign.end,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),

                    primary: Colors.blueAccent, // This is what you need!
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
