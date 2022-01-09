import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/pages/main/upcoming/videocall_page.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/fullscreen_dialog_widget.dart';
import 'package:lettutor/widgets/note_dialog.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class UpcomingCard extends StatefulWidget {
  const UpcomingCard({Key? key, required this.schedule, required this.onUpdate}) : super(key: key);
  final Schedule schedule;
  final Function onUpdate;

  @override
  _UpcomingCardState createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  double _animatedHeight = 100.0;

  displayDialog(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => FullScreenDialog(title: title, content: content),
        fullscreenDialog: true,
      ),
    ).then((value) {
      widget.onUpdate();
    });
  }

  Future<bool> cancelSchedule(BuildContext context) async {
    try {
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false)
          .auth
          .tokens!
          .access!
          .token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      List<String> ids = [widget.schedule.scheduleDetailId!];
      await dio.delete("booking", data: {
        'scheduleDetailIds[]': ids,
      });
      return true;
    } catch (e) {
      inspect(e);
      return false;
    }
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lesson Time : " +
                      (widget.schedule.scheduleDetailInfo?.startPeriod ?? "00: 00") +
                      " - " +
                      (widget.schedule.scheduleDetailInfo?.endPeriod ?? "00: 00"),
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
                            children: [
                              Icon(Icons.arrow_drop_down),
                              Text("Requirements", style: TextStyle(fontSize: 18)),
                              Spacer(),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    displayDialog(
                                      context,
                                      "Special Request",
                                      NoteDialog(scheduleId: widget.schedule.id!),
                                    );
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.blue),
                                  ),
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
                            widget.schedule.studentRequest == null
                                ? "Currently there are no requests for this class. Please write down any requests for the teacher."
                                : (widget.schedule.studentRequest ?? ""), //
                            style: TextStyle(fontSize: 16, color: Color(0xff8399a7)),
                            maxLines: 3,
                          ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomizedButton(
                  borderRadius: 5,
                  btnText: "Cancel",
                  icon: Icons.disabled_by_default,
                  primaryColor: Colors.red,
                  horizontalPadding: 0,
                  verticalPadding: 0,
                  textSize: 17,
                  onTap: () async {
                    bool result = await cancelSchedule(context);
                    if (result == true) {
                      widget.onUpdate();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Delete schedule failed, try again later",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }
                  },
                ),
                PrimaryButton(
                  isDisabled: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoCallPage()),
                    );
                  },
                  width: 150,
                  text: "Join",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
