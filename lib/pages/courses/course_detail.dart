import 'package:flutter/material.dart';
import 'package:lettutor/pages/courses/tab/course_detail_main_item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({Key? key, this.title, this.subTitle, this.banner, this.lesson, this.level}) : super(key: key);

  final title;
  final subTitle;
  final banner;
  final lesson;
  final level;

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
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
          title: const Text(
            "Course Detail",
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message_outlined,color: Colors.white,),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            CourseDetailMainItem(
              title: widget.title,
              subTitle: widget.subTitle,
              banner: widget.banner,
              level: widget.level,
              lesson: widget.lesson,
            ),
            Text(
              "Overview",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text("Why take this course", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                  "Movies and television shows are common topics of conversation among friends and coworkers. In this course, you"
                  " will practice discussing the movies and television shows you've seen and sharing your opinions about them"
                  "."),
            ),
            Text("What will you be able to do", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                  "You will learn vocabulary related to movies and television.  In addition, you will practice the grammatical structures that help you tell a story, and share and explain your likes and dislikes."),
            ),
            Text(
              "Experience Level",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              widget.level,
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            Text(
              "Course Length",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              widget.lesson + " topics",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            Text(
              "List Topics",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text("1. You Favorite Movie", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            Text("2. You Favorite Film", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            Text("3. You Favorite TV Show", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            Text("4. You Favorite Reality TV", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            Text("5. You Favorite Animel", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
          ],
        ),
      ),
    );
  }
}
