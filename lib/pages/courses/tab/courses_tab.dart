import 'package:flutter/material.dart';
import 'package:lettutor/pages/courses/tab/course_item.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({Key? key}) : super(key: key);

  @override
  _CourseTabState createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoursesItem(
          title: "Basic Conversation Topics (New)",
          subTitle: "Gain confidence speaking about familiar topics",
          lesson: "10r",
          level: "Beginner",
          banner: "asset/beginner.png",
        )
      ],
    );
  }
}
