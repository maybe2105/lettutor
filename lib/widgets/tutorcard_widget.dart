import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/pages/profile/tutor_detail_page.dart';
import 'package:lettutor/pages/schedule/private_message_page.dart';
import 'package:lettutor/widgets/tutorcardtag_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TutorCardWidget extends StatefulWidget {
  const TutorCardWidget(
      {Key? key, required this.name, required this.avatar, required this.star, required this.isFavorite, required this.content})
      : super(key: key);

  final String name;

  final String avatar;

  final double star;

  final bool isFavorite;

  final String content;

  @override
  _TutorCardWidgetState createState() => _TutorCardWidgetState();
}

class _TutorCardWidgetState extends State<TutorCardWidget> {
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
                    image: NetworkImage(widget.avatar),
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
                          child: Text(widget.name),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                          child: RatingBar.builder(
                            initialRating: widget.star,
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
                        ),
                        const TutorCardTag(content: "English")
                      ],
                    ),
                  ),
                ),
                getFavorite(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              widget.content,
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
                                name: widget.name,
                                avatar: widget.avatar,
                                star: widget.star,
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
                        name: widget.name,
                        avatar: widget.avatar,
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
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  Widget getFavorite() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Icon(MdiIcons.heart),
    );
  }
}
