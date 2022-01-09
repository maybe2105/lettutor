import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/secondary_button.dart';
import 'package:provider/provider.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({Key? key,  required this.tutorId, required this.name}) : super(key: key);
  final String tutorId;

  final String name;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  TextEditingController messageController = TextEditingController();
  bool isSubmitDisabled = true;

  bool _annoy = false;

  bool _scam = false;

  bool _another = false;

  Future<void> sendReport(BuildContext context) async {
    try {
      var accessToken = Provider.of<AuthProvider>(context, listen: false)
          .auth
          .tokens!
          .access!
          .token;
      var dio = Http().client;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      await dio.post(
        "report",
        data: {
          "tutorId": widget.tutorId,
          "content": messageController.text,
        },
      );
      Navigator.pop(context);
    } catch (e) {
      inspect(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Report failed, try again later",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Report ${widget.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.report,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      child: Text(
                        "Help us understand what's happening",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: _annoy, onChanged: (value){
                      setState(() {
                        _annoy = value?? false;

                      });
                    }),
                    const SizedBox(width: 4,),
                    const Text('This tutor annoying me')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: _scam, onChanged: (value){
                      setState(() {
                        _scam = value?? false;

                      });
                    }),
                    const SizedBox(width: 4,),
                    const Expanded(child: Text('This profile is pretending to be someone or is fake'))
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: _another, onChanged: (value){
                      setState(() {
                        _another = value?? false;

                      });
                    }),
                    const SizedBox(width: 4,),
                    const Text('Another reason')
                  ],
                ),
                TextFormField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Let us know details about your problem',
                  ),
                  maxLines: 3,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SecondaryButton(isDisabled: false, onPressed: (){
                      Navigator.of(context).pop();
                    }, text: 'Cancel'),
                    SecondaryButton(isDisabled: true, onPressed: (){
                      sendReport(context);
                    }, text: 'Submit')
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
