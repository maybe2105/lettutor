import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/sumit_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TeacherInfomation extends StatefulWidget {
  const TeacherInfomation({Key? key, required this.user, required this.onUpdateInfo}) : super(key: key);

  final User user;
  final Function onUpdateInfo;

  @override
  _TeacherInfomationState createState() => _TeacherInfomationState();
}

class _TeacherInfomationState extends State<TeacherInfomation> {
  final commonInfoForm = GlobalKey<FormState>();
  bool showDatePicker = false;
  User? userData;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  String? country;
  DateTime? birthday;
  List<String> specialties = [];
  List<String> levels = [
    "BEGINNER",
    "HIGHER_BEGINNER",
    "PRE_INTERMEDIATE",
    "INTERMEDIATE",
    "UPPER_INTERMEDIATE",
    "ADVANCED",
    "PROFICIENCY"
  ];
  String levelValue = "BEGINNER";

  @override
  void initState() {
    super.initState();
    setState(() {
      userData = widget.user;
      nameController = TextEditingController(text: userData!.name);
      emailController = TextEditingController(text: userData!.email);
      phoneController = TextEditingController(text: userData!.phone);
      country = userData!.country;
      if (userData!.birthday != null) {
        List<String> dayStr = userData!.birthday!.split("-");
        if (dayStr.length == 3) {
          int year = int.tryParse(dayStr[0]) ?? 2000;
          int month = int.tryParse(dayStr[1]) ?? 1;
          int day = int.tryParse(dayStr[2]) ?? 1;
          birthday = DateTime(year, month, day);
        }
      }
    });
  }

  Future<void> updateCommonInfo(BuildContext context) async {
    try {
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      // String fileName = imagePath.split('/').last;
      var data = {
        'name': nameController?.text ?? "default",
        'phone': phoneController?.text ?? "000000000",
        'country': country,
        'level': levelValue,
        'birthday': DateFormat('yyyy-MM-dd').format(birthday ?? DateTime.now()),
      };
      await dio.put('user/info', data: data);
      widget.onUpdateInfo();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Update user data failed, try again later",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
      inspect(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: commonInfoForm,
      child: Container(
        padding: EdgeInsets.all(24),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0,0,0,16),

              child: Row(
                children: [
                  Text("Edit Profile",style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: "Name",
                ),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: "Email",
                ),
                enabled: false,
                controller: emailController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text("Country: "),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                      ),
                      child: CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          setState(() {
                            country = countryCode.toString();
                          });
                        },
                        initialSelection: country,
                        showOnlyCountryWhenClosed: true,
                        showCountryOnly: true,
                        alignLeft: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: "Phone",
                ),
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
                enabled: userData?.isPhoneActivated == true ? false : true,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: CustomizedButton(
                btnText: birthday != null
                    ? DateFormat(
                        'EE, dd MMM y',
                      ).format(
                        DateTime.fromMillisecondsSinceEpoch(birthday?.millisecondsSinceEpoch ?? 0),
                      )
                    : "Birthday",
                onTap: () {
                  setState(() {
                    showDatePicker = true;
                  });
                },
              ),
            ),
            if (showDatePicker == true)
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: SfDateRangePicker(
                  showTodayButton: true,
                  view: DateRangePickerView.month,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    setState(() {
                      birthday = args.value;
                      showDatePicker = false;
                    });
                  },
                  onCancel: () {
                    setState(() {
                      showDatePicker = false;
                    });
                  },
                ),
              ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Level: ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black38,
                  width: 1,
                ),
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: SizedBox(),
                items: levels.map<DropdownMenuItem>((String selectedValue) {
                  return DropdownMenuItem(
                    child: Text(selectedValue),
                    value: selectedValue,
                  );
                }).toList(),
                value: levelValue,
                onChanged: (dynamic newValue) {
                  print(newValue.toString());
                  setState(() {
                    levelValue = newValue;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 150,
                  child: SubmitButton(
                    btnText: "Save",
                    onTap: () {
                      if (commonInfoForm.currentState!.validate()) {
                        updateCommonInfo(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
