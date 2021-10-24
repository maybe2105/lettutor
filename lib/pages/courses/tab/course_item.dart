import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoursesItem extends StatefulWidget {
  const CoursesItem({Key? key, this.banner, this.title, this.subTitle, this.level, this.lesson}) : super(key: key);

  final banner;
  final title;
  final subTitle;
  final level;
  final lesson;

  @override
  _CoursesItemState createState() => _CoursesItemState();
}

class _CoursesItemState extends State<CoursesItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: 260,
      decoration:
          BoxDecoration(border: Border.all(color: Color.fromRGBO(216, 216, 216, 1)), borderRadius: BorderRadius.circular(16)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              widget.banner,
              height: 200,
              width: 260,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.subTitle,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(widget.level + " • " + widget.lesson + " Lessons"),
          )
        ],
      ),
    );
  }
}
