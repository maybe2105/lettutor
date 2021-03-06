import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/history_card.dart';
import 'package:lettutor/widgets/upcoming_card.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Upcoming",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message_outlined),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SvgPicture.asset(
              'assets/calendar.svg',
              width: 120,
              height: 120,
            ),
          ),
          const Text(
            "Lịch đã đặt",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.grey, width: 3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Đây là danh sách những khung giờ bạn đã đặt", style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(
                    "Bạn có thể theo dõi khi nào buổi học bắt đầu, tham gia buổi học bằng một cú nhấp chuột hoặc có thể hủy buổi học trước 2 tiếng.",
                    style: TextStyle(fontSize: 20, color: Colors.grey))
              ],
            ),
          ),
          const UpcomingCard(
              time: "T6,22 Thng 10,21",
              duration: 25,
              country: "Vietnam",
              countryTag: "🇻🇳",
              name: "Luân Nguyễn",
              review: "Gia sư tạm được",
              avatar: "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/e/eb/DWG_ShowMaker_2019_Split_1"
                  ".png/revision/latest/scale-to-width-down/250?cb=20190722060549"),
          const UpcomingCard(
              time: "T5,22 Thng 9,21",
              duration: 30,
              country: "Russia",
              countryTag: "🇷🇺",
              name: "Daniel Ishutin",
              review: "Gia sư pro",
              avatar: "https://cdn.vox-cdn.com/thumbor/GdW2s_q8FXW1s_jhP1XCUm7eZ_k=/0x0:492x554/1200x800/filters:focal"
                  "(184x147:262x225)/cdn.vox-cdn.com/uploads/chorus_image/image/61133845/dendi_navi.0.png"),
          const UpcomingCard(
              time: "T5,22 Thng 8,21",
              duration: 15,
              country: "Korea",
              countryTag: "🇰🇷",
              name: "Jeong Ji-hoon ",
              requirement: "Test requirement 3",
              review: "Gia sư hay",
              avatar:
                  "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/0/02/HLE_Chovy_2021_Split_2.png/revision/latest?cb=20210610234156"),
        ],
      ),
    );
  }
}
