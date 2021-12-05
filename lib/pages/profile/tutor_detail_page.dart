import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/models/tutor_dto.dart';
import 'package:lettutor/pages/schedule/private_message_page.dart';
import 'package:lettutor/widgets/booking_dialog.dart';
import 'package:lettutor/widgets/expandable_text.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/report_dialog.dart';
import 'package:lettutor/widgets/reviews_dialog.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/taglist_widget.dart';
import 'package:lettutor/widgets/time_table.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({Key? key, required this.tutor}) : super(key: key);

  final TutorDTO tutor;

  @override
  _TutorDetailPageState createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  var isFavorite = false;

  double getTotalRating() {
    double result = 0;
    for (var i = 0; i < widget.tutor.feedbacks!.length; i++) {
      result = result + widget.tutor.feedbacks!.elementAt(i).rating!;
    }

    return result / widget.tutor.feedbacks!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: SizedBox(
            width: 150,
            child: SvgPicture.asset('assets/login_logo.svg', semanticsLabel: 'LetTutor logo'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomCircleAvatar(dimension: 100, avatarUrl: widget.tutor.avatar ?? ""),
                      const SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.tutor.name ?? "",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: getTotalRating(),
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
                                    const Text("(2)")
                                  ],
                                )),
                            SizedBox(
                              width: 150,
                              child: CountryCodePicker(
                                alignLeft: true,
                                initialSelection: widget.tutor.country ?? "VN",
                                showOnlyCountryWhenClosed: true,
                                enabled: false,
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ExpandableText(content: widget.tutor.bio ?? ""),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PrivateMessagePage(
                              name: widget.tutor.name,
                              avatar: widget.tutor.avatar ?? "",
                            ),
                          ));
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.message_outlined,
                              color: Colors.blue,
                            ),
                            Text(
                              'Message',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.blue : Colors.blue,
                            ),
                            Text(
                              'Favorite',
                              style: TextStyle(color: isFavorite ? Colors.blue : Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ReportDialog(
                              name: widget.tutor.name,
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.report_outlined,
                              color: Colors.blue,
                            ),
                            Text(
                              'Report',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const ReviewsDialog(),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.star_border_rounded,
                              color: Colors.blue,
                            ),
                            Text(
                              'Reviews',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(color: Colors.black54),
                    child: const Center(child: Text("Mockup Video Player")),
                  ),
                  const Text(
                    'Languages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child:  TagsList(
                        tagsList: widget.tutor.languages!.split(",").toList(),
                        selectFirstItem: false,
                        readOnly: true,
                    ),
                  ),
                  const Text(
                    'Specialities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Wrap(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'English for business',
                            isActive: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'Advanced',
                            isActive: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'English for kids',
                            isActive: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Suggested courses',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      text: const TextSpan(
                          text: 'Demo Course: ',
                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Link', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.normal))
                          ]),
                    ),
                  ),
                  const Text(
                    'Interests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Lorem ipsum sample text interest of tutor sample text is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Teaching experience',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Sample text of teacher lorem ipsume is simply dummy text of the printing and typesetting industry. "
                      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  Row(
                    children: [
                      PrimaryButton(
                        isDisabled: false,
                        onPressed: () => {},
                        text: "Today",
                        width: 120,
                        height: 40,
                      ),
                      IconButton(onPressed: () => {}, icon: const Icon(MdiIcons.chevronLeft)),
                      IconButton(onPressed: () => {}, icon: const Icon(MdiIcons.chevronRight)),
                      const Text(
                        'Oct, 2021',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TimeTable(
                onPressBook: () {
                  showDialog(
                    context: context,
                    builder: (context) => const BookingDialog(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
