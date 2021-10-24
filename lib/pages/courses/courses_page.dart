import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/courses/course_detail.dart';
import 'package:lettutor/pages/courses/tab/course_item.dart';
import 'package:lettutor/pages/courses/tab/courses_tab.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
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
            "Courses",
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView(
          children: [
            SvgPicture.asset(
              'assets/courses.svg',
              width: 100,
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Discover Courses",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who "
              "are in need of improving their knowledge of the fields.",
              style: TextStyle(wordSpacing: 0.5, fontSize: 16),
            ),
            Wrap(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton(
                    items: <String>[
                      'Any Level',
                      'Beginner',
                      'Upper-Beginner',
                      'Pre-intermediate',
                      'Intermediate',
                      'Upper-Intermediate',
                      'Pre-Advanced',
                      'Advanced',
                      'Post-Advanced'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    hint: Text("Select Level"),
                  ),
                ),
                Container(
                  child: DropdownButton(
                    items: <String>[
                      'English for beginners',
                      'English for kids',
                      'Business English',
                      'Conversational English',
                      'For Studying Aboard',
                      'English for travelling',
                      'PET',
                      'MOVER',
                      'FLYER',
                      'TOEIC',
                      'IETLS'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    hint: Text("Select category"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton(
                    items: <String>[
                      'Ascending',
                      'Decending',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    hint: Text("Sort by level"),
                  ),
                )
              ],
            ),
            const Text("Course"),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Text(
                "English for beginners",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourseDetailPage(
                              title: "Basic Conversation Topics (New)",
                              subTitle: "Gain confidence speaking about familiar topics",
                              lesson: "10",
                              level: 'beginner',
                              banner: "assets/beginner.png")),
                    );
                  },
                  child: const CoursesItem(
                    title: "Basic Conversation Topics (New)",
                    subTitle: "Gain confidence speaking about familiar topics",
                    lesson: "10",
                    level: "Beginner",
                    banner: "assets/beginner.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourseDetailPage(
                              title: "Intermediate Conversation Topics (New)",
                              subTitle: "Express your ideas and opinions",
                              lesson: "10",
                              level: 'intermediate',
                              banner: "assets/intermediate.png")),
                    );
                  },
                  child: CoursesItem(
                    title: "Intermediate Conversation Topics (New)",
                    subTitle: "Express your ideas and opinions",
                    lesson: "10",
                    level: "Intermediate",
                    banner: "assets/intermediate.png",
                  ),
                )
              ],
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Text(
                "Controversional English",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourseDetailPage(
                              title: "Healthy Mind, Healthy Body (New)",
                              subTitle: "Let's discuss the many aspects of living a long, happy life",
                              lesson: "6",
                              level: 'Intermediate',
                              banner: "assets/intermediate-contro.png")),
                    );
                  },
                  child: const CoursesItem(
                    title: "Healthy Mind, Healthy Body (New)",
                    subTitle: "Let's discuss the many aspects of living a long, happy life",
                    lesson: "6",
                    level: "Intermediate",
                    banner: "assets/intermediate-contro.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourseDetailPage(
                              title: "Movies and Television (New)",
                              subTitle: "Let's discuss the many aspects of living a long, happy life",
                              lesson: "6",
                              level: 'Beginner',
                              banner: "assets/beginner-contro.png")),
                    );
                  },
                  child: const CoursesItem(
                    title: "Movies and Television (New)",
                    subTitle: "Let's discuss our preferences and habits surrounding movies and television shows",
                    lesson: "10",
                    level: "Beginner",
                    banner: "assets/beginner-contro.png",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
