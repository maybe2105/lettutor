import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/fullscreen_dialog_widget.dart';
import 'package:lettutor/widgets/reviews_dialog.dart';
import 'package:provider/provider.dart';

class AvatarBlock extends StatefulWidget {
  const AvatarBlock({Key? key, required this.user, required this.onUpdateInfo}) : super(key: key);
  final User user;
  final Function onUpdateInfo;

  @override
  _AvatarBlockState createState() => _AvatarBlockState();
}

class _AvatarBlockState extends State<AvatarBlock> {
  String imagePath = "";

  displayDialog(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => FullScreenDialog(title: title, content: content),
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> uploadAvatar(BuildContext context) async {
    try {
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      inspect(imagePath);
      // String fileName = imagePath.split('/').last;
      var formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          imagePath,
          // filename: fileName,
        ),
      });
      await dio.post('user/uploadAvatar', data: formData);
      widget.onUpdateInfo();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Upload failed, try again later",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
      inspect(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    return widget.user.id == null
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(30,16,30,30),

            child: Column(
              children: [
                Row(
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: 90,
                            height: 90,
                            child: CircleAvatar(
                              radius: 130,
                              backgroundImage: NetworkImage(
                                widget.user.avatar ?? "",
                              ),
                              backgroundColor: Colors.transparent,
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color.fromRGBO(0, 113, 240, 1),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              // maxWidth: 500,
                              // maxHeight: 500,
                              // imageQuality: 50,
                            );
                            if (image != null) {
                              setState(() {
                                imagePath = image.path;
                              });
                              await uploadAvatar(context);
                            }
                          },
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.user.name ?? "",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: Text(
                    "ID: " + (widget.user.id ?? ""),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top:8),
                  child: InkWell(
                    child: Text(
                      "Your Reviews",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(0, 113, 240, 1),
                      ),
                    ),
                    onTap: () => {
                      showDialog(
                        context: context,
                        builder: (context) => ReviewsDialog(
                          feedbacks: widget.user != null ? widget.user.feedbacks : widget.user.feedbacks,
                        ),
                      )
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
