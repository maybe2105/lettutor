import 'package:flutter/material.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/secondary_button.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog({Key? key}) : super(key: key);

  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 650,
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff0f0f0), width: 1))),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    "Chi tiết đặt lịch",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all(color: Color(0xfff0f0f0)), color: const Color(0xfffafafa)),
                    child: const Text(
                      "Thời gian đặt lịch",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all(color: Color(0xfff0f0f0))),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Color(0xffeeeaff)),
                      child: const Text(
                        "21:00 - 21:25 thứ bảy, 23 tháng 10 2021",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xfff0f0f0),
                  ),
                  color: Color(0xfffafafa)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: const [
                        Text(
                          "Số dư",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "Bạn còn 1 buổi học",
                          style: TextStyle(color: Color(0xff7766C7), fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: const [
                        Text(
                          "Giá",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "2 buổi học",
                          style: TextStyle(color: Color(0xff7766C7), fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          decoration: const BoxDecoration(color: Colors.lightBlueAccent),
                          child: const Text("BẢN XỨ", style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const Flexible(
                          child: Text(
                            "Giáo viên bản xứ sẽ có giá thuê cao hơn giáo viên thông thường",
                            style: TextStyle(color: Color(0xffFAAD14), fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff0f0f0)),
              ),
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all(color: Color(0xfff0f0f0)), color: const Color(0xfffafafa)),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Notes",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all(color: Color(0xfff0f0f0))),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        minLines: 5,
                        maxLines: 5,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff0f0f0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(
                      isDisabled: false,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: "Huỷ"),
                  PrimaryButton(isDisabled: false, onPressed: () {}, text: "Đặt lịch")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
