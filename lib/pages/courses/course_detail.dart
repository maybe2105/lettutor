import 'package:flutter/material.dart';
import 'package:lettutor/models/course.dart';
import 'package:lettutor/pages/courses/tab/course_detail_main_item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({
    Key? key,
    this.data,
  }) : super(key: key);

  final Course? data;

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
        child: const Icon(
          Icons.message_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            CourseDetailMainItem(
                title: widget.data!.name!,
                subTitle: widget.data!.description!,
                banner: widget.data!.imageUrl!,
                level: widget.data!.categories!.elementAt(0).key!,
                lesson: widget.data!.topics!.length.toString()),
            Text(
              "Overview",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Why take this course", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.data!.reason!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("What will you be able to do", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.data!.purpose!,
              ),
            ),
            Text(
              "Experience Level",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.people_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  Text(
                    widget.data!.categories!.elementAt(0).key!,
                    style: TextStyle(
                      fontSize: 16,
                      color:Colors.blueAccent
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Course Length",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.data!.topics!.length.toString() + " topics",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            Text(
              "List Topics",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.data!.topics!.length,
                  itemBuilder: (context, position) {
                    return Text(
                      (position + 1).toString() +
                          ". " +
                          widget.data!.topics!
                              .elementAt(position)
                              .name!,
                      style:  TextStyle( fontSize: 16)
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
