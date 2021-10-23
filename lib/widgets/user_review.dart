import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';

class UserReview extends StatelessWidget {
  const UserReview({Key? key, required this.username, required this.content, required this.rating}) : super(key: key);
  final username;
  final content;
  final rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCircleAvatar(dimension: 32, avatarUrl: 'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/0/02/HLE_Chovy_2021_Split_2.png/revision/latest?cb=20210610234156'),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  username,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  '1 day ago',
                  style: TextStyle(color: Colors.black12),
                )
              ],
            ),
            RatingBar.builder(
              initialRating: rating,
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
            Text(content)
          ],
        )
      ],
    );
  }
}
