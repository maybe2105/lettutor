import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/widgets/descriptiontext_widget.dart';
import 'package:lettutor/widgets/iconwithtextunder_widget.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';
import 'package:lettutor/widgets/tutorcardtag_widget.dart';
import 'package:lettutor/widgets/tutortag_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BookingTutorPage extends StatefulWidget {
  const BookingTutorPage({Key? key}) : super(key: key);

  @override
  _BookingTutorPageState createState() => _BookingTutorPageState();
}

class _BookingTutorPageState extends State<BookingTutorPage> {
  final star = 5.0;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedToday = formatter.format(now);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/login_logo.svg',
          width: 170,
          height: 40,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CustomCircleAvatar(
                  avatarUrl: "https://pbs.twimg.com/profile_images/1253490180717240320/5zc_pIC1_400x400.jpg",
                  dimension: 120,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Khắc Luân",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: star,
                                ignoreGestures: true,
                                itemSize: 20,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              Text("(2)")
                            ],
                          )),
                      Row(
                        children: [
                          Image.asset(
                            'icons/flags/png/vn.png',
                            package: 'country_icons',
                            width: 40,
                            height: 40,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Việt Nam",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DescriptionTextWidget(
                text:
                    "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia."),
          ),
          GridView.count(
            crossAxisCount: 4,
            physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            children: const [
              IconWithTextUnder(icon: Icons.message_outlined, text: "Nhắn tin"),
              IconWithTextUnder(icon: Icons.favorite_outline, text: "Yêu thích"),
              IconWithTextUnder(icon: Icons.warning_outlined, text: "Báo cáo"),
              IconWithTextUnder(icon: Icons.star_outline, text: "Xem đánh giá")
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(color: Colors.black54),
              child: const Center(child: Text("Mockup Video Player")),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Ngôn ngữ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              children: const [TutorCardTag(content: "English")],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Chuyên ngành",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(children: const [
              TutorCardTag(content: "English"),
              TutorCardTag(content: "TOEIC"),
              TutorCardTag(content: "IETLS"),
              TutorCardTag(content: "Tiếng Anh cho trẻ em")
            ]),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Sở thích",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "I loved travelling playing game hangingout with friends etc... loren ipsum long text 123",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Kinh nghiệm giảng dạy",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "I dont have any kinh nghiệm giảng dạy lorem ipsum very long test abcdef nguyen khac luan",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Row(
              children: [
                PrimaryButton(
                  isDisabled: false,
                  onPressed: () => {},
                  text: "Today",
                  width: 120,
                  height: 40,
                ),
                IconButton(onPressed: () => {}, icon: const Icon(MdiIcons.chevronLeft)),
                IconButton(onPressed: () => {}, icon: const Icon(MdiIcons.chevronRight))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              formattedToday,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
