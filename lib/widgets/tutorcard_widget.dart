import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/pages/profile/tutor_detail_page.dart';
import 'package:lettutor/pages/schedule/book_schedule_dialog.dart';
import 'package:lettutor/pages/schedule/private_message_page.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/fullscreen_dialog_widget.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/tutorcardtag_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class TutorCardWidget extends StatefulWidget {
  const TutorCardWidget({Key? key, required this.tutorData, this.hideFavorite, this.booking}) : super(key: key);

  final Tutor tutorData;
  final bool? hideFavorite;
  final bool? booking;

  @override
  _TutorCardWidgetState createState() => _TutorCardWidgetState();
}

class _TutorCardWidgetState extends State<TutorCardWidget> {
  bool isFavorited = false;

  displayDialog(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => FullScreenDialog(title: title, content: content),
        fullscreenDialog: true,
      ),
    ).then((value) {
      getDetail();
    });
  }

  void getDetail() {
    try {
      print("tutorId: ${widget.tutorData.id}");
      var dio = Http().client;
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
        var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
        dio.options.headers["Authorization"] = "Bearer $accessToken";
        var res = await dio.get(
          "tutor/${widget.tutorData.id}",
        );
        Tutor data = Tutor.fromJson(res.data);
        setState(() {
          isFavorited = data.isFavorite ?? false;
        });
      });
    } catch (e) {
      inspect(e);
    }
  }

  Future<void> switchFavorite(BuildContext context) async {
    try {
      var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
      var dio = Http().client;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.post(
        "user/manageFavoriteTutor",
        data: {'tutorId': widget.tutorData.user == null ? widget.tutorData.userId : widget.tutorData.user?.id},
      );
      inspect(res);
      setState(() {
        isFavorited = !isFavorited;
      });
    } catch (e) {
      inspect(e);
    }
  }

  @override
  void initState() {
    super.initState();
    isFavorited = widget.tutorData.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TutorDetailPage(tutorId: widget.tutorData.userId ?? widget.tutorData.user!.id!)),
        );
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
                      image: NetworkImage(
                        widget.tutorData.user != null ? widget.tutorData.user!.avatar! : (widget.tutorData.avatar ?? ""),
                      ),
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
                              widget.tutorData.user != null ? widget.tutorData.user!.name! : (widget.tutorData.name ?? ""),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                            child: RatingBar.builder(
                              initialRating: widget.tutorData.avgRating == null ? 0 : widget.tutorData.avgRating!.toDouble(),
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
                          // const TutorCardTag(content: "English")
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: (widget.tutorData.specialties != null
                                        ? widget.tutorData.specialties!.split(",").toList()
                                        : [])
                                    .map((item) => TutorCardTag(content: item))
                                    .toList()),
                          )
                        ],
                      ),
                    ),
                  ),
                  widget.hideFavorite == null
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Icon(
                              isFavorited ? Icons.favorite : Icons.favorite_border,
                              color: isFavorited ? Colors.red : Colors.blue,
                              size: 26,
                            ),
                            onTap: () {
                              switchFavorite(context);
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.tutorData.bio ?? "",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    displayDialog(
                      context,
                      "Book",
                      BookScheduleDialog(
                        tutorId: widget.tutorData.user == null ? widget.tutorData.userId : widget.tutorData.user!.id,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getFavorite() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Icon(
        MdiIcons.heart,
        color: Colors.blueAccent,
      ),
    );
  }
}
