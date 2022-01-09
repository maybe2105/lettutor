import 'package:flutter/material.dart';
import 'package:lettutor/widgets/user_review.dart';
import 'package:lettutor/models/feedback.dart' as feedbackModel;

class ReviewsDialog extends StatefulWidget {
  const ReviewsDialog({Key? key, this.feedbacks = const []}) : super(key: key);

  final List<feedbackModel.Feedback>? feedbacks;


  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Others review',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close_sharp))
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.fromLTRB(16, 0, 16, 16),
                child:   (widget.feedbacks ?? []).length > 0 ? ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: (widget.feedbacks ?? []).map((e) => UserReview(data : e)).toList(),
                ) : Text("No review",style:TextStyle(fontWeight:FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
