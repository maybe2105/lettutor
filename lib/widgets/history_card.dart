import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryCard extends StatefulWidget {
  const HistoryCard({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  final Schedule schedule;

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
            DateFormat(
              'EE, dd MMM y',
            ).format(
              DateTime.fromMillisecondsSinceEpoch(widget.schedule.scheduleDetailInfo?.startPeriodTimestamp ?? 0),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.schedule.scheduleDetailInfo?.startPeriodTimestamp ?? 0)),
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
                  avatarUrl: widget.schedule.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.avatar ?? "",
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
                      widget.schedule.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Container(
                      child: CountryCodePicker(
                        initialSelection: widget.schedule.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.country ?? "VN",
                        showOnlyCountryWhenClosed: true,
                        enabled: false,
                        padding: EdgeInsets.all(0),
                        alignLeft: false,
                      ),
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
                          "Message",
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
              "Lesson Time: " +
                  (widget.schedule.scheduleDetailInfo?.startPeriod ?? "00: 00") +
                  " - " +
                  (widget.schedule.scheduleDetailInfo?.endPeriod ?? "00: 00"),
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
                  children: [Text("Requirements", style: TextStyle(fontSize: 18)), Spacer(), Icon(Icons.arrow_drop_down)],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                      widget.schedule.studentRequest == null
                          ? "No requirement for student"
                          : (widget.schedule.studentRequest ?? ""),
                      style: TextStyle(fontSize: 16)),
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
            child: Text(widget.schedule.tutorReview == null ? "No review for this tutor" : (widget.schedule.tutorReview ?? ""),
                style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }
}
