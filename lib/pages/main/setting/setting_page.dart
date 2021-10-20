import 'package:flutter/material.dart';
import 'package:lettutor/widgets/settingitem_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Image(
                      image: NetworkImage("https://static.wikia.nocookie"
                          ".net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2"
                          ".png/revision/latest/scale-to-width-down/250?cb=20200903154623"),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Nguyễn Khắc Luân",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("luannguyen210500@gmail.com")
                    ],
                  )
                ],
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
                icon: Icons.person,
                text: "Booking",
                onClick: () {},
              ),
              SettingItem(
                icon: Icons.person,
                text: "Session",
                onClick: () {},
              ),
              SettingItem(
                icon: Icons.person,
                text: "Advanced Settings",
                onClick: () {},
              ),
              const SizedBox(
                height: 28,
              ),
              SettingItem(
                icon: Icons.person,
                text: "Our website",
                onClick: () {},
              ),
              SettingItem(
                icon: Icons.person,
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
