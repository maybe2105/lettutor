import 'package:flutter/material.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/pages/profile/tutor_detail_page.dart';
import 'package:lettutor/pages/schedule/private_message_page.dart';
import 'package:lettutor/widgets/tutorcardtag_widget.dart';

class NoFavoriteTutorCard extends StatelessWidget {
  const NoFavoriteTutorCard({Key? key, required this.tutorData})
      : super(key: key);
  final Tutor tutorData;
  double getTotalRating() {
    double result = 0;
    for (var i = 0; i < tutorData.feedbacks!.length; i++) {
      result = result + tutorData.feedbacks!.elementAt(i).rating!;
    }

    return result / tutorData.feedbacks!.length;
  }
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical:8),
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
                    image: NetworkImage(tutorData.avatar ?? ""),
                    width: 40,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          tutorData.name ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8),
                        child: Row(
                          children: [
                            Text(
                              getTotalRating().toString() ,
                              style: const TextStyle(color: Colors.orange),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TutorCardTag(
                          content: "All",
                        ),
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
              tutorData.bio ?? "",
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
                            tutorId: tutorData.userId ?? tutorData.user!.id!,
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Book",
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
                        name: tutorData.name,
                        avatar: tutorData.avatar ?? "",
                      ),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Row(
                      children: const [
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
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
    ;
  }
}
