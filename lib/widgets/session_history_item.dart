import 'package:flutter/material.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';

class SessionHistoryItem extends StatelessWidget {
  const SessionHistoryItem({Key? key, this.day, this.lesson, this.name, this.avatar}) : super(key: key);
  final day;
  final lesson;
  final name;
  final avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.lightGreenAccent,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                ),
                Text(lesson.toString() + " consecutive lessons")
              ],
            )),
        Padding(
          padding: const EdgeInsets.all( 16),
          child: Row(
            children: [
              CustomCircleAvatar(dimension: 60, avatarUrl: avatar),
              const SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Text(
                      "🇻🇳 Việt Nam",
                      style: TextStyle(fontSize: 14),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.message,
                          color: Colors.blueAccent,
                          size: 18,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Direct Message",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.blue)),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Lesson Time: 00:00 - 00:25",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(0)),
                        color: Color(0xff607d8b)),
                    child: Text("No request for this lesson", style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(8)),
                        color: Color(0xff607d8b)),
                    child: Text("Teacher hasn't reviewed yet", style: TextStyle(color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.blue)),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Lesson Time: 00:30 - 00:55",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(0)),
                        color: Color(0xff607d8b)),
                    child: Text("No request for this lesson", style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(8)),
                        color: Color(0xff607d8b)),
                    child: Text("Teacher hasn't reviewed yet", style: TextStyle(color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
