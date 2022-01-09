import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/primary_button.dart';

class CourseDetailMainItem extends StatefulWidget {
  const CourseDetailMainItem({Key? key, this.banner, this.title, this.subTitle, this.level, this.lesson}) : super(key: key);

  final banner;
  final title;
  final subTitle;
  final level;
  final lesson;

  @override
  _CourseDetailMainItemState createState() => _CourseDetailMainItemState();
}

class _CourseDetailMainItemState extends State<CourseDetailMainItem> {
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
            child: Image.network(
              widget.banner,
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
            padding: const EdgeInsets.fromLTRB( 16,0,16,16),
            child: Text(
              widget.subTitle,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),

        ],
      ),
    );
  }
}
