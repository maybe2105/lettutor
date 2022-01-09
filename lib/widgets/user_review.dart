import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';

import 'package:lettutor/models/feedback.dart' as feedbackModel;
import 'package:timeago/timeago.dart' as timeago;

class UserReview extends StatelessWidget {
  const UserReview({
    Key? key,
    required this.data,
  }) : super(key: key);

  final feedbackModel.Feedback data;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(
          dimension: 32,
          avatarUrl: data.firstInfo!.avatar ?? "",
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data.firstInfo!.name ?? "default",
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  timeago.format(data.createdAt!),
                  style: TextStyle(color: Colors.black12),
                )
              ],
            ),
            RatingBar.builder(
              initialRating: data.rating!.toDouble(),
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
            Text(
              data.content ?? "",
            )
          ],
        )
      ],
    );
  }
}
