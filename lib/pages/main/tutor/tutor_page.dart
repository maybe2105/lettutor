import 'package:flutter/material.dart';
import 'package:lettutor/widgets/tutorcard_nofavorite_widget.dart';
import 'package:lettutor/widgets/tutortag_widget.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tutor",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 1),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TutorTag(content: "All"),
                      TutorTag(content: "Business"),
                      TutorTag(content: "Travel"),
                      TutorTag(content: "Starter"),
                      TutorTag(content: "Mover"),
                      TutorTag(content: "Flyer"),
                      TutorTag(content: "Advanced")
                    ],
                  ),
                ),
              ),
              const NoFavoriteTutorCard(
                  name: "Khắc Luân",
                  avatar:
                      "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2.png/revision/latest/scale-to-width-down/250?cb=20200903154623",
                  star: 5,
                  content: "lorem ipsum text test no content"),
              const NoFavoriteTutorCard(
                  name: "Khắc Luân",
                  avatar:
                  "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2.png/revision/latest/scale-to-width-down/250?cb=20200903154623",
                  star: 5,
                  content: "lorem ipsum text test no content"),
              const NoFavoriteTutorCard(
                  name: "Khắc Luân",
                  avatar:
                  "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2.png/revision/latest/scale-to-width-down/250?cb=20200903154623",
                  star: 5,
                  content: "lorem ipsum text test no content"),
              const NoFavoriteTutorCard(
                  name: "Khắc Luân",
                  avatar:
                  "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2.png/revision/latest/scale-to-width-down/250?cb=20200903154623",
                  star: 5,
                  content: "lorem ipsum text test no content")
            ],
          ),
        ));
  }
}
