import 'package:flutter/material.dart';
import 'package:lettutor/pages/main/upcoming/videocall_page.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UpcomingCard extends StatefulWidget {
  const UpcomingCard(
      {Key? key, this.time, this.duration, this.name, this.country, this.countryTag, this.requirement, this.review, this.avatar})
      : super(key: key);

  final time;

  final duration;

  final name;
  final country;
  final countryTag;
  final avatar;

  final requirement;
  final review;

  @override
  _UpcomingCardState createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  double _animatedHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xfff1f1f1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "1 buổi học",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(vertical: 16),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                CustomCircleAvatar(
                  avatarUrl: widget.avatar,
                  dimension: 75,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      widget.countryTag + " " + widget.country,
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: const [
                        Icon(
                          MdiIcons.chatOutline,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Nhắn tin",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thời gian bài học: " + widget.duration.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xfffafafa),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xffe0e0e0),
                        ),
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _animatedHeight != 0.0 ? _animatedHeight = 0.0 : _animatedHeight = 100.0;
                          }),
                          child: Row(
                            children: const [
                              Icon(Icons.arrow_drop_down),
                              Text("Yêu cầu buổi học", style: TextStyle(fontSize: 18)),
                              Spacer(),
                              Flexible(
                                child: Text(
                                  "Chỉnh sửa yêu cầu",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(microseconds: 100),
                        child: Container(
                          height: _animatedHeight,
                          padding: EdgeInsets.all(16),
                          child: Text(
                              widget.requirement ??
                                  "Hiện tại không có yêu cầu cho lớp học này. Xin vui lòng viết ra bất kỳ yêu cầu nào cho giáo viên nếu có.",
                              style: TextStyle(fontSize: 16, color: Color(0xff8399a7)),maxLines: 3,),
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            child: PrimaryButton(
              isDisabled: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoCallPage()),
                );
              },
              text: "Vào buổi học",
              width: 200,
            ),
          )
        ],
      ),
    );
  }
}
