import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/models/category.dart';
import 'package:lettutor/models/course.dart';
import 'package:lettutor/pages/courses/course_detail.dart';
import 'package:lettutor/pages/courses/tab/course_item.dart';
import 'package:lettutor/pages/courses/tab/courses_tab.dart';
import 'package:lettutor/services/auth_provider.dart';
import 'package:lettutor/services/http.dart';
import 'package:lettutor/widgets/customize_button.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/taglist_widget.dart';
import 'package:provider/provider.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  int page = 1;
  int size = 5;
  int count = 0;
  List<String> levelsTag = [];
  var sortValue;
  List<int> selectedLevels = [];
  List<Category> categories = [];
  List<String> categoriesTags = [];
  List<String> selectedCategories = [];
  TextEditingController qController = TextEditingController();
  List<Course> courseList = [];
  bool loading = true;

  List<int> convertLevelToIndex(List<String> levels) {
    List<int> result = [];
    for (int i = 0; i < levels.length; i++) {
      int index = levelsTag.indexWhere((element) => element == levels[i]);
      if (index >= 0) {
        result.add(index);
      }
    }
    return result;
  }

  List<String> convertCategoriesToId(List<String> temp) {
    List<String> result = [];
    for (int i = 0; i < temp.length; i++) {
      int index = categories.indexWhere((element) => element.title == temp[i]);
      if (index >= 0 && categories[index].id != null) {
        result.add(categories[index].id ?? "");
      }
    }
    return result;
  }

  Future<void> getCourseList(bool resetList) async {
    try {
      setState(() {
        if (resetList == true) {
          courseList.clear();
          page = 1;
        }
        loading = true;
      });
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var query = {'page': page, 'size': size, 'level': selectedLevels, 'categoryId': selectedCategories, 'q': qController.text};
      var res = await dio.get("course", queryParameters: query);
      Iterable i = res.data["data"]["rows"];
      List<Course> data = List<Course>.from(i.map((course) => Course.fromJson(course)));
      setState(() {
        courseList.addAll(data);
        count = res.data["data"]["count"];
        loading = false;
      });
    } catch (e) {
      inspect(e);
    }
  }

  Future<void> getCategories() async {
    try {
      var dio = Http().client;
      var accessToken = Provider.of<AuthProvider>(context, listen: false).auth.tokens!.access!.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get(
        "content-category",
      );
      Iterable i = res.data["rows"];
      List<Category> result = List<Category>.from(i.map((category) => Category.fromJson(category)));
      setState(() {
        categories = result;
        categoriesTags = result.map((ele) => ele.title ?? "").toList();
      });
    } catch (e) {
      inspect(e);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      setState(() {
        levelsTag = [
          'Any Level',
          'Beginner',
          'Upper-Beginner',
          'Pre-intermediate',
          'Intermediate',
          'Upper-Intermediate',
          'Pre-Advanced',
          'Advanced',
          'Post-Advanced'
        ];
      });
      await getCategories();
      await getCourseList(true);
    });
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
          title: const Text(
            "Courses",
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView(
          children: [
            SvgPicture.asset(
              'assets/courses.svg',
              width: 100,
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Discover Courses",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who "
              "are in need of improving their knowledge of the fields.",
              style: TextStyle(wordSpacing: 0.5, fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Type to search",
                        prefixIcon: GestureDetector(
                          child: Icon(Icons.search),
                        ),
                      ),
                      controller: qController,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  PrimaryButton(
                    onPressed: () async {
                      await getCourseList(true);
                    },
                    text: 'Search',
                    isDisabled: false,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TagsList(
                tagsList: categoriesTags,
                isHorizontal: true,
                onSelectedList: (p0) async {
                  setState(() {
                    selectedCategories = convertCategoriesToId(p0);
                  });
                  await getCourseList(true);
                },
              ),
              padding: EdgeInsets.only(bottom: 10),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TagsList(
                tagsList: levelsTag,
                isHorizontal: true,
                onSelectedList: (p0) async {
                  setState(() {
                    selectedLevels = convertLevelToIndex(p0);
                  });
                  await getCourseList(true);
                },
              ),
              padding: EdgeInsets.only(bottom: 10),
            ),
            Container(
              alignment: Alignment.centerLeft,
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
                icon: Icon(
                  Icons.keyboard_arrow_down,
                ),
                isExpanded: true,
                underline: SizedBox(),
                items: ["Level Ascending", "Level Descreasing"].map<DropdownMenuItem>((String selectedValue) {
                  return DropdownMenuItem(
                    child: Text(selectedValue),
                    value: selectedValue,
                  );
                }).toList(),
                hint: Text("Sort by level"),
                value: sortValue,
                onChanged: (dynamic newValue) async {
                  setState(() {
                    sortValue = newValue.toString();
                  });
                  await getCourseList(true);
                },
              ),
            ),
            const Text("Course"),
            courseList.length > 0
                ? Wrap(
                    children: courseList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  CourseDetailPage(
                                        data: e),
                              ));
                            },
                            child: CoursesItem(
                              data: e,
                            ),
                          ),
                        )
                        .toList(),
                  )
                : loading == true
                    ? Container()
                    : Container(
                        child: Text(
                          "No data",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 20),
                      ),
            size * page < count && loading == false
                ? Container(
                    child: CustomizedButton(
                      btnText: "Load more",
                      onTap: () async {
                        setState(() {
                          page = page + 1;
                        });
                        await getCourseList(false);
                      },
                      hasBorder: false,
                      textSize: 20,
                    ),
                    margin: EdgeInsets.only(
                      top: 16,
                      bottom: 4,
                    ),
                  )
                : Container(),
            loading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
