import 'package:flutter/material.dart';
import 'package:lettutor/widgets/rounded_avatar_widget.dart';

class PrivateMessagePage extends StatefulWidget {
  const PrivateMessagePage({Key? key, this.name, this.avatar}) : super(key: key);
  final name;
  final avatar;

  @override
  _PrivateMessagePageState createState() => _PrivateMessagePageState();
}

class _PrivateMessagePageState extends State<PrivateMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            CustomCircleAvatar(
              avatarUrl: widget.avatar ?? "",
              dimension: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.name,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        hintText: 'Type your message here',
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
