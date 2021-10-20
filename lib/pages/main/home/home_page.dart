import 'package:flutter/material.dart';
import 'package:lettutor/widgets/tutorcard_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home",style: TextStyle(
          color:Colors.black,
          fontSize:16,
        ),),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.indigoAccent,
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Welcome to LetTutor",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      child: const Text(
                        "Book a lesson?",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
          ///////////////////////////////////////////
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              "Recommended",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          const TutorCardWidget(
            name: "Luân Nguyễn",
            avatar: "https://www.pngkit.com/png/full/192-1924580_spoderman-transparent-gif-spooderman-original.png",
            content:
                "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy te"
                "xt ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It ha",
            isFavorite: true,
            star: 2.5,
          ),
          const TutorCardWidget(
            name: "Luân đẹp trai",
            avatar: "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/f/f5/DWG_ShowMaker_2020_Split_2.png/revision/latest/scale-to-width-down/250?cb=20200903154623",
            content:
            "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy te"
                "xt ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It ha",
            isFavorite: true,
            star: 5,
          ),
        ],
      ),
    );
  }
}
