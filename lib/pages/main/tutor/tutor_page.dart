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
                  avatar:"https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/4/48/HLE_Chovy_2021_Split_1.png/revision/latest/scale-to-width-down/250?cb=20210211035132",
                  star: 5,
                  content:
                      "lorem ipsum text test no content,lorem ipsum text test no content,lorem ipsum text test no content,lorem ipsum text test no contentlorem ipsum text test no content"),
              const NoFavoriteTutorCard(
                  name: "Test name",
                  avatar:
                      "https://static.wikia.nocookie.net/towerofgod/images/2/26/BaamS3Ch64.png/revision/latest?cb=20200604164221",
                  star: 3.5,
                  content:
                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum"),
              const NoFavoriteTutorCard(
                  name: "DK Shoemaker",
                  avatar:
                      "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2.png/revision/latest/scale-to-width-down/250?cb=20200903154623",
                  star: 2.5,
                  content:
                      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a"),
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
