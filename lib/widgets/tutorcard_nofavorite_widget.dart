import 'package:flutter/material.dart';
import 'package:lettutor/pages/profile/tutor_detail_page.dart';
import 'package:lettutor/pages/schedule/private_message_page.dart';
import 'package:lettutor/widgets/tutorcardtag_widget.dart';

class NoFavoriteTutorCard extends StatelessWidget {
  const NoFavoriteTutorCard({Key? key, required this.name, required this.avatar, required this.star, required this.content})
      : super(key: key);
  final String name;

  final String avatar;

  final double star;

  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Image(
                    image: NetworkImage(avatar),
                    width: 40,
                    height: 40,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: TutorCardTag(
                            content: "All",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      Text(
                        star.toString(),
                        style: const TextStyle(color: Colors.orange),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              content,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TutorDetailPage(
                                name: name,
                                avatar: avatar,
                                star: star,
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Đặt lịch",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PrivateMessagePage(
                        name: name,
                        avatar: avatar,
                      ),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.message,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Nhắn tin",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
    ;
  }
}
