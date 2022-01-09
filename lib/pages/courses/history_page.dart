import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/history_card.dart';
import 'package:provider/provider.dart';

class StudentBookingHistoryPage extends StatefulWidget {
  const StudentBookingHistoryPage({Key? key}) : super(key: key);

  @override
  _StudentBookingHistoryPageState createState() => _StudentBookingHistoryPageState();
}

class _StudentBookingHistoryPageState extends State<StudentBookingHistoryPage> {
  bool loading = true;
  int page = 1;
  int perPage = 5;
  int count = 0;
  List<Schedule> scheduleList = [];

  Future<void> getSchedules(bool resetList) async {
    try {
      setState(() {
        if (resetList == true) {
          scheduleList.clear();
          page = 1;
        }
        loading = true;
      });
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var query = {
        'page': page,
        'perPage': perPage,
        'dateTimeLte': DateTime.now().millisecondsSinceEpoch,
        'orderBy': 'meeting',
        'sortBy': 'desc'
      };
      var res = await dio.get("booking/list/student", queryParameters: query);
      Iterable i = res.data["data"]["rows"];
      List<Schedule> data = List<Schedule>.from(i.map((schedule) => Schedule.fromJson(schedule)));
      setState(() {
        scheduleList.addAll(data);
        count = res.data["data"]["count"];
        loading = false;
      });
    } catch (e) {
      inspect(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getSchedules(true);
  }

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
            "Booking History",
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
         
          Container(
            child: scheduleList.length > 0
                ? ListView(
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    primary: false,
                    children: scheduleList
                        .map(
                          (e) => HistoryCard(schedule: e,),
                        )
                        .toList(),
                  )
                : loading == true
                    ? Container()
                    : Container(
                        child: Text(
                          "No data",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 20),
                      ),
          ),
          page * perPage < count && loading == false
              ? Container(
                  child: CustomizedButton(
                    btnText: "Load more",
                    onTap: () async {
                      setState(() {
                        page = page + 1;
                      });
                      await getSchedules(false);
                    },
                    hasBorder: false,
                    textSize: 20,
                  ),
                  margin: EdgeInsets.only(
                    top: 16,
                    bottom: 4,
                  ),
                )
              : Container(),
           loading == true
              ? Center(
                child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 50.0,
                    width: 50.0,
                  ),
              )
              : Container(),
        ],
      ),
    );
  }
}
