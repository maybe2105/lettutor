import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/fullscreen_dialog_widget.dart';
import 'package:lettutor/widgets/note_dialog.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

class UpcomingCardTitle extends StatefulWidget {
  const UpcomingCardTitle({Key? key, required this.schedule, required this.onUpdate}) : super(key: key);
  final Schedule schedule;
  final Function onUpdate;

  @override
  _UpcomingCardTitleState createState() => _UpcomingCardTitleState();
}

class _UpcomingCardTitleState extends State<UpcomingCardTitle> {
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {},
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.white,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Lesson Time: " +
                        (widget.schedule.scheduleDetailInfo?.startPeriod ?? "00: 00") +
                        (widget.schedule.scheduleDetailInfo?.endPeriod ?? "00: 00"),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Table(
                  border: TableBorder.all(
                    color: Color(0xfff0f0f0),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color(0xfff0f0f0),
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    "Requirements",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      CustomizedButton(
                                        hasBorder: false,
                                        btnText: "Edit",
                                        background: Colors.transparent,
                                        textSize: 16,
                                        horizontalPadding: 0,
                                        verticalPadding: 0,
                                        onTap: () => {
                                          debugPrint('movieTitle: click'),
                                          displayDialog(
                                            context,
                                            "Special Request",
                                            NoteDialog(
                                              scheduleId: widget.schedule.id!,
                                            ),
                                          ),
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            widget.schedule.studentRequest == null
                                ? "Currently there are no requests for this class. Please write down any requests for the teacher."
                                : (widget.schedule.studentRequest ?? ""), // will show this if there is no notes
                            style: TextStyle(
                              color: Color(0xff8399a7),
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
