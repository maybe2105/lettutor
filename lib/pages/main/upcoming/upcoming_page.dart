import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/history_card.dart';
import 'package:lettutor/widgets/upcoming_card.dart';
import 'package:provider/provider.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
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
        'dateTimeGte': DateTime.now().millisecondsSinceEpoch,
        'orderBy': 'meeting',
        'sortBy': 'asc'
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
            "Schedule",
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
                Text("Here is a list of the sessions you have booked", style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text(
                    "You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
                    style: TextStyle(fontSize: 20, color: Colors.grey))
              ],
            ),
          ),
          Container(
            child: scheduleList.length > 0
                ? ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: scheduleList
                        .map(
                          (e) => UpcomingCard(
                            schedule: e,
                            onUpdate: () async {
                              await getSchedules(true);
                            },
                          ),
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
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
