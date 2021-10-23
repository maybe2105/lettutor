import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/session_history_item.dart';

class SessionHistoryPage extends StatefulWidget {
  const SessionHistoryPage({Key? key}) : super(key: key);

  @override
  _SessionHistoryPageState createState() => _SessionHistoryPageState();
}

class _SessionHistoryPageState extends State<SessionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Session History",
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: ListView(
        children: [
          SessionHistoryItem(
            day: "Wed, 20 Oct 21",
            lesson: 2,
            name: "Khắc Luân",
            avatar:
                "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2.png/revision/latest/scale-to-width-down/250?cb=20200903154623",
          ),
          SessionHistoryItem(
            day: "Wed, 19 Oct 21",
            lesson: 2,
            name: "Demo name",
            avatar:
            "https://m.media-amazon.com/images/I/51tEXq0ZDcL._AC_SL1000_.jpg",
          )
        ],
      ),
    );
  }
}
