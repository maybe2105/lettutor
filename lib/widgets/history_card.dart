import 'package:flutter/material.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({Key? key, this.time, this.duration, this.name, this.country, this.countryTag, this.requirement, this.review, this.avatar})
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
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
            "1 day ago",
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
            child: Text(
              "Thời gian bài học: " + widget.duration.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Text("Yêu cầu buổi học", style: TextStyle(fontSize: 18)), Spacer(), Icon(Icons.arrow_drop_down)],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(widget.requirement, style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Text(widget.review, style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }
}
