import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/history_card.dart';

class StudentBookingHistoryPage extends StatefulWidget {
  const StudentBookingHistoryPage({Key? key}) : super(key: key);

  @override
  _StudentBookingHistoryPageState createState() => _StudentBookingHistoryPageState();
}

class _StudentBookingHistoryPageState extends State<StudentBookingHistoryPage> {
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
            "Booking History",
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )),
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
              'assets/history.svg',
              width: 120,
              height: 120,
            ),
          ),
          const Text(
            "Lịch sử các buổi học",
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
                Text("Đây là danh sách các bài học bạn đã tham gia", style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text("Bạn có thể xem lại thông tin chi tiết về các buổi học đã tham gia đã tham gia",
                    style: TextStyle(fontSize: 20, color: Colors.grey))
              ],
            ),
          ),
          const HistoryCard(
              time: "T6,22 Thng 10,21",
              duration: 25,
              country: "Vietnam",
              countryTag: "🇻🇳",
              name: "Luân Nguyễn",
              requirement: "Test requirement 1",
              review: "Gia sư tạm được",
              avatar: "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/e/eb/DWG_ShowMaker_2019_Split_1"
                  ".png/revision/latest/scale-to-width-down/250?cb=20190722060549"),
          const HistoryCard(
              time: "T5,22 Thng 9,21",
              duration: 30,
              country: "Russia",
              countryTag: "🇷🇺",
              name: "Daniel Ishutin",
              requirement: "Test requirement 2",
              review: "Gia sư pro",
              avatar: "https://cdn.vox-cdn.com/thumbor/GdW2s_q8FXW1s_jhP1XCUm7eZ_k=/0x0:492x554/1200x800/filters:focal"
                  "(184x147:262x225)/cdn.vox-cdn.com/uploads/chorus_image/image/61133845/dendi_navi.0.png"),
          const HistoryCard(
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
