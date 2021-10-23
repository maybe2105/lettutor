import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({Key? key}) : super(key: key);

  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/login_logo.svg',
          width: 170,
          height: 40,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          const Icon(
            MdiIcons.calendar,
            size: 128,
          ),
          const Text(
            "Lịch đã được đặt",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey, width: 3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                children: const [
                  Text(
                    "Đây là danh sách những khung giờ bạn đặt",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  Text(
                      "Bạn có thể theo dõi khi nào buổi học bắt đầu và tham gia buổi học bằng một cú nhấp "
                      "chuột hoặc huỷ buổi học trước 2 tiến",
                      style: TextStyle(fontSize: 20, color: Colors.grey))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Hôm nay",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 22),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Icon(Icons.calendar_today)
                        ],
                      )),
                )
              ],
            ),
          ),
          Table(
            border: TableBorder.all(
              color: const Color(0xfff0f0f0),
              style: BorderStyle.solid,
              width: 1,
            ),
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: Color(0xfff0f0f0),
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'Notes',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        minLines: 5,
                        maxLines: 5,
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
