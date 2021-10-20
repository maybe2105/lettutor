import 'package:flutter/material.dart';
import 'package:lettutor/pages/main/home/home_page.dart';
import 'package:lettutor/pages/main/message/message_page.dart';
import 'package:lettutor/pages/main/setting/setting_page.dart';
import 'package:lettutor/pages/main/tutor/tutor_page.dart';
import 'package:lettutor/pages/main/upcoming/upcoming_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  var _pageController;

  final tabs = [
    const HomePage(),
    const MessagePage(),
    const UpcomingPage(),
    const TutorPage(),
    const SettingPage(),
  ];


  @override
  void initState() {
    _pageController = PageController(initialPage: selectedIndex);
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onTapHandler(int index)  {
    setState(() {
      selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: _pageController,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Upcoming",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Tutor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }
}
