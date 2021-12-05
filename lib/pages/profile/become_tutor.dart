import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/taglist_widget.dart';


import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:video_player/video_player.dart';

class BecomeTutorPage extends StatefulWidget {
  const BecomeTutorPage({Key? key}) : super(key: key);

  @override
  _BecomeTutorPageState createState() => _BecomeTutorPageState();
}

enum Level { Beginner, Intermediate, Advanced }

class _BecomeTutorPageState extends State<BecomeTutorPage> {
  final stepOneForm = GlobalKey<FormState>();
  final stepTwoForm = GlobalKey<FormState>();
  int _currentStep = 0;
  bool showDatePicker = false;
  Level? _level = Level.Beginner;
  String imagePath = "";
  String countryCode = "";
  String language = "";
  final ImagePicker picker = ImagePicker();
  DateTime? birthday;
  var nameController = TextEditingController();
  var interestsController = TextEditingController();
  var educationController = TextEditingController();
  var expController = TextEditingController();
  var professionController = TextEditingController();
  var introController = TextEditingController();
  List<String> specialties = [];
  VideoPlayerController? videoController;
  Future<void>? initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    setState(() {
      countryCode = "VN";
      language = "VN";
    });
  }

  @override
  void dispose() {
    videoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tagsList = [
     "English for kid",
      "English for business",
      "Conversational",
      "STARTERS",
      "MOVERS",
      "FLYERS",
      "KET",
      "PET",
      "IELTS",
      "TOEFL",
      "TOEIC",
    ];
    List<Step> getSteps() => [
      Step(
        isActive: _currentStep >= 0,
        title: const Text(
          "Complete profile",
          overflow: TextOverflow.ellipsis,
        ),
        content: Form(
          key: stepOneForm,
          child: Container(
            padding: const EdgeInsets.only(top: 0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.5),
                  child: const Text(
                    "Set up your tutor profile",
                    style: TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.5),
                  child: const Text(
                    "Your tutor profile is your chance to market yourself to students on Tutoring. You can make edits later on your profile settings page.",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    "New students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already.",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.5),
                  child: Column(
                    children: [
                      const Divider(
                        color: Colors.red,
                      ),
                      const Text(
                        "Basic info",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CustomizedButton(
                        btnText: "Upload avatar here",
                        icon: Icons.image,
                        onTap: () async {
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              imagePath = image.path;
                            });
                          }
                        },
                      ),
                      imagePath.isEmpty
                          ? const Text(
                        "required",
                        style: TextStyle(color: Colors.red),
                      )
                          : Container(),
                      imagePath != ""
                          ? Container(
                        child: Image.file(File(imagePath)),
                      )
                          : Container(),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 1),
                            ),
                            hintText: "Tutor name",
                          ),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            const Text("I'm from: "),
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
                                  onChanged: (CountryCode country) {
                                    setState(() {
                                      countryCode = country.toString();
                                    });
                                  },
                                  initialSelection: countryCode,
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
                        margin: const EdgeInsets.only(bottom: 20),
                        child: CustomizedButton(
                          btnText: birthday == null
                              ? "Ngày sinh"
                              : birthday.toString(),
                          onTap: (){
                            setState(() {
                              showDatePicker = true;
                            });

                          },
                        ),
                      ),
                      if (showDatePicker == true)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: SfDateRangePicker(
                            showTodayButton: true,
                            view: DateRangePickerView.month,
                            onSelectionChanged:
                                (DateRangePickerSelectionChangedArgs args) {
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
                      birthday == null
                          ? const Text(
                        "required",
                        style: TextStyle(color: Colors.red),
                      )
                          : Container(),
                      const Divider(
                        color: Colors.red,
                      ),
                      const Text(
                       "CV",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Students will view this information on your profile to decide if you're a good fit for them.",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 1),
                            ),
                            hintText:  "Interests, hobbies, memorable life experiences, or anything else you'd like to share!",
                            alignLabelWithHint: true,
                            hintMaxLines: 5,
                            labelText: "Interests",
                          ),
                          controller: interestsController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 1),
                            ),
                            hintText: "Example:Bachelor of Arts in English from Cambly University; Certified yoga instructor, Second Language Acquisition and Teaching  (SLAT) certificate from Cambly University",
                            alignLabelWithHint: true,
                            hintMaxLines: 5,
                            labelText:"Education",
                          ),
                          controller: educationController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 1),
                            ),
                            hintText:"Experience",
                          ),
                          controller: expController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 1),
                            ),
                            hintText:  "Current or Previous Profession",
                          ),
                          controller: professionController,
                        ),
                      ),
                      const Divider(
                        color: Colors.red,
                      ),
                      const Text(
                        "Languages",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Row(
                          children: [
                            const Text("Languages: "),
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
                                      language = countryCode.toString();
                                    });
                                  },
                                  initialSelection: language,
                                  showOnlyCountryWhenClosed: true,
                                  showCountryOnly: true,
                                  alignLeft: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.red,
                      ),
                      const Text(
                        "Who i teach",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 1),
                            ),
                            hintText:
                            "Example: I was a doctor for 35 years and can help you practice business or medical English. I also enjoy teaching beginners as I am very patient and always speak slowly and clearly.",
                            alignLabelWithHint: true,
                            hintMaxLines: 5,
                            labelText: "Introduction",
                          ),
                          controller: introController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "I am best at teaching students who are",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 16),
                            ),
                            ListTile(
                              title: const Text("Beginner"),
                              leading: Radio<Level>(
                                value: Level.Beginner,
                                groupValue: _level,
                                onChanged: (Level? value) {
                                  setState(() {
                                    _level = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text("Intermediate",),
                              leading: Radio<Level>(
                                value: Level.Intermediate,
                                groupValue: _level,
                                onChanged: (Level? value) {
                                  setState(() {
                                    _level = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text("Advanced",),
                              leading: Radio<Level>(
                                value: Level.Advanced,
                                groupValue: _level,
                                onChanged: (Level? value) {
                                  setState(() {
                                    _level = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "My specialties are",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TagsList(
                        tagsList: tagsList,
                        selectFirstItem: false,
                        onSelectedList: (list) {
                          setState(() {
                            specialties = list;
                          });
                        },
                      ),
                      specialties.isEmpty
                          ? const Text(
                        "required",
                        style: TextStyle(color: Colors.red),
                      )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        isActive: _currentStep >= 1,
        title: const Text(
          "Video introduction",
          overflow: TextOverflow.ellipsis,
        ),
        content: Form(
          key: stepTwoForm,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.5),
                  child: const Text(
                    "Introduce yourself",
                    style: TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.5),
                  child: const Text(
    "Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, "
        "expertise and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you.",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const Divider(
                  color: Colors.red,
                ),
                const Text(
                  "Introduction video",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomizedButton(
                  btnText: "Choose video",
                  icon: Icons.image,
                  onTap: () async {
                    final XFile? video =
                    await picker.pickVideo(source: ImageSource.gallery);
                    if (video != null) {
                      setState(() {
                        videoController =
                            VideoPlayerController.file(File(video.path));
                        initializeVideoPlayerFuture =
                            videoController!.initialize();
                        videoController!.setLooping(true);
                        videoController!.play();
                      });
                    }
                  },
                ),
                videoController == null
                    ? const Text(
                  "required",
                  style: TextStyle(color: Colors.red),
                )
                    : Container(),
                initializeVideoPlayerFuture != null
                    ? Container(
                  child: FutureBuilder(
                    future: initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio:
                          videoController!.value.aspectRatio,
                          child: VideoPlayer(videoController!),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      Step(
        isActive: _currentStep >= 2,
        title: const Text(
          "Approval",
          overflow: TextOverflow.ellipsis,
        ),
        content: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.sentiment_satisfied_alt,
                size: 100,
                color: Colors.blue,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: const Text(
                  "You have done all the steps.Please, wait for the operator's approval",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ];
    return Stepper(
      type: StepperType.vertical,
      steps: getSteps(),
      currentStep: _currentStep,
      onStepContinue: () {
        bool isLastStep = _currentStep == getSteps().length - 1;
        if (isLastStep) {
          Navigator.of(context).pop();
        } else {
          if (_currentStep == 0) {
            if (stepOneForm.currentState!.validate() &&
                imagePath.isNotEmpty &&
                birthday != null &&
                specialties.length > 0) {
              setState(() {
                _currentStep += 1;
              });
            }
          } else if (_currentStep == 1) {
            if (stepTwoForm.currentState!.validate() &&
                videoController != null) {
              setState(() {
                _currentStep += 1;
              });
            }
          }
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) {
          setState(() {
            _currentStep -= 1;
          });
        }
      },
      controlsBuilder: (context, {onStepCancel, onStepContinue}) {
        return Container(
          margin: const EdgeInsets.only(top: 50),
          child: Row(
            children: [
              _currentStep < getSteps().length - 1
                  ? Expanded(
                child: ElevatedButton(
                  child: const Text( "Back",),
                  onPressed: onStepCancel,
                ),
              )
                  : Container(),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ElevatedButton(
                  child: Text(_currentStep == getSteps().length - 1
                      ? "Back home"
                      : "Next"),
                  onPressed: onStepContinue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}