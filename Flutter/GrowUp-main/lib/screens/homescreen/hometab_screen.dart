import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/coursemodel.dart';
import 'package:growup/screens/tutorscreen/searchtutor.dart';
import 'package:growup/screens/coursescreen/courseinfo.dart';
import 'package:growup/screens/coursescreen/course_item.dart';
import 'package:growup/screens/profilescreen/profile_screen.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/widgets/shimmer.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HomeTabScreen extends StatefulWidget {
  //   late final Skills skills;
  // HomeTabScreen({
  //   required this.skills,
  // });

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  var _skillsDetail;
  var _skillsVideos;
  String? _selectedItem;
  void initState() {
    super.initState();
    _skillsDetail = getSkillDetails();
    ifContains();
  }

  bool ifContains() {
    if (_skillsDetail.toString() == "Development") {
      print("YESDSHFKDJSHFDSHFDKJF");
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor1,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: loadData,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFFFBFB),
                  Color(0xffEEEEEE),
                ],
              ),
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: edge,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, Nabin",
                            style: regularTextStyle.copyWith(
                                fontSize: 21, color: Color(0xFF5C5A5A)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Let's start learning",
                            style: blackTextStyle.copyWith(fontSize: 23),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                        future: _skillsDetail,
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.data == null ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(width: 1, color: greyColor)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Center(
                                  child: TextField(
                                    onTap: () {
                                      // showSearch(
                                      //     context: context, delegate: SearchCourse());
                                    },
                                    cursorColor: Colors.red,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        //    prefixIcon: Icon(Icons.search, color: Colors.black),
                                        hintText: 'Search your course...',
                                        hintStyle: TextStyle(
                                            fontSize: 19,
                                            color: Color(0xFF575656))),
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.hasData ||
                              snapshot.data != null ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            var skillsData = snapshot.data!;
                            print(
                                "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
                            print(
                              skillsData[0].titleImage,
                            );

                            List<String> skillNameList = [];
                            int i = 0;
                            late List<String> nameList;
                            for (i = 0; i <= (skillsData.length - 1); i++) {
                              skillNameList.add(skillsData![i].title);
                              nameList = skillNameList;
                            }

                            return Container(
                              height: 65,
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SearchField(
                                suggestions: nameList,
                                hint: 'Search your course...',
                                searchStyle: TextStyle(
                                  fontSize: 19,
                                  color: Color(0xFF575656),
                                ),
                                searchInputDecoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: greyColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: darkBlueColor.withOpacity(0.8),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                maxSuggestionsInViewPort: 6,
                                itemHeight: 45,
                                suggestionState: SuggestionState.hidden,
                                suggestionsDecoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFF8A8A8A),
                                        blurRadius: 14,
                                        spreadRadius: 1,
                                        offset: Offset(3, 3)),
                                  ],
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onTap: (value) async {
                                  var videoData = getSkillVideos(1);
                                  setState(() {
                                    _selectedItem = value!;

                                    print(_selectedItem);
                                    print(nameList.indexOf(value));
                                    var indexIs = nameList.indexOf(value);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CourseInfo(
                                                name: _selectedItem,
                                                //  imageUrl: skillsData[indexIs]
                                                //  .titleImage,
                                                imageUrl: "images/course.png",
                                                skillId: 1
                                                //    imageUrl:
                                                //  "https://d861-2400-1a00-b020-932d-9ca7-220a-313f-4867.ngrok.io/Media/Images/1439ecf5-5f06-4afc-a538-c800712fbea2mobileapplication.png",
                                                )));
                                  });

                                  print(value);
                                },
                              ),
                            );
                          }
                          return Container();
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.024,
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        'images/btn_search.png',
                        width: 43,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff99B7FF),
                        Color(0xff6077F7),
                      ],
                    ),
                    color: Colors.purple[900],
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '70% off',
                              style: whiteTextStyle.copyWith(
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Mar 30 - Apr 5',
                              style: whiteTextStyle.copyWith(fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffFE876C),
                                    Color(0xffFD5D37),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Text(
                                  'Join Now',
                                  style: whiteTextStyle.copyWith(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'images/course.png',
                              width: 130,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Subject
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: edge),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Skills To Pump',
                          style: blackTextStyle.copyWith(fontSize: 25),
                        ),
                      ),
                    ),
                    //   Image.network(
                    //      "https://1462-2400-1a00-b020-f9ee-c8cb-f076-23cd-a8a8.ngrok.io/Media/Images/1439ecf5-5f06-4afc-a538-c800712fbea2mobileapplication.png"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: edge),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'See all',
                          style:
                              softpurpleColorTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                    future: _skillsDetail,
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.data == null ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: MediaQuery.of(context).size.width * 0.7,
                          //color: Colors.red,
                          child: ListView.builder(
                            // physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, myindex) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      buildShimmerEffect(
                                        context,
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasData ||
                          snapshot.data != null ||
                          snapshot.connectionState == ConnectionState.done) {
                        var _courseList = snapshot.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 15),
                              child:
                                  // Text(
                                  //   'Development Courses',
                                  //   style: blackTextStyle.copyWith(fontSize: 18),
                                  // ),
                                  FutureBuilder<dynamic>(
                                future: getVideosCount(1),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    //userFinalDetails!.fullName.toString()
                                    var videosCount = snapshot.data.toString();
                                    return Row(
                                      children: [
                                        Text(
                                          'Development Courses',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)
                                                      .withOpacity(.8),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          " | " + videosCount + " Videos",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                      255, 100, 100, 100)
                                                  .withOpacity(.8),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.8),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    );
                                  }
                                  return SizedBox(
                                    height: 18,
                                    width: 18,
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.7,
                              //color: Colors.red,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _courseList.length,
                                itemBuilder: (context, myindex) {
                                  return _courseList[myindex]
                                              .skillCategoryId
                                              .toString() ==
                                          "1"
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CourseItem(
                                              name: _courseList[myindex].title,
                                              imageUrl: _courseList[myindex]
                                                  .titleImage,
                                              skillId: 1,
                                              // imageUrl:
                                              //   "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                                              //  "https://d861-2400-1a00-b020-932d-9ca7-220a-313f-4867.ngrok.io/Media/Images/1439ecf5-5f06-4afc-a538-c800712fbea2mobileapplication.png",
                                              // noOfVideos: _courseList[myindex]
                                              //      .noOfVideos,
                                              noOfVideos: 6,
                                              skill: _courseList[myindex]
                                                  .skillCategoryId,
                                              // skill: skillsdevelopment[index],
                                            )
                                          ],
                                        )
                                      : Container();
                                },
                              ),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 15),
                              child: FutureBuilder<dynamic>(
                                future: getVideosCount(2),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    //userFinalDetails!.fullName.toString()
                                    var videosCount = snapshot.data.toString();
                                    return Row(
                                      children: [
                                        Text(
                                          'Design Courses',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)
                                                      .withOpacity(.8),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          " | " + videosCount + " Videos",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                      255, 100, 100, 100)
                                                  .withOpacity(.8),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.8),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    );
                                  }
                                  return SizedBox(
                                    height: 18,
                                    width: 18,
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.7,
                              //color: Colors.red,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _courseList.length,
                                itemBuilder: (context, myindex) {
                                  return _courseList[myindex]
                                              .skillCategoryId
                                              .toString() ==
                                          "2"
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CourseItem(
                                              name: _courseList[myindex].title,
                                              imageUrl: _courseList[myindex]
                                                  .titleImage,
                                              skillId: 2,
                                              //  "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                                              // "https://d861-2400-1a00-b020-932d-9ca7-220a-313f-4867.ngrok.io/Media/Images/1439ecf5-5f06-4afc-a538-c800712fbea2mobileapplication.png",
                                              noOfVideos: 6,
                                              skill: _courseList[myindex]
                                                  .skillCategoryId,
                                              // skill: skillsdevelopment[index],
                                            )
                                          ],
                                        )
                                      : Container();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 15),
                              child: FutureBuilder<dynamic>(
                                future: getVideosCount(3),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    //userFinalDetails!.fullName.toString()
                                    var videosCount = snapshot.data.toString();
                                    return Row(
                                      children: [
                                        Text(
                                          'Marketing Courses',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)
                                                      .withOpacity(.8),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          " | " + videosCount + " Videos",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                      255, 100, 100, 100)
                                                  .withOpacity(.8),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.8),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    );
                                  }
                                  return SizedBox(
                                    height: 18,
                                    width: 18,
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.7,
                              //color: Colors.red,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _courseList.length,
                                itemBuilder: (context, myindex) {
                                  return _courseList[myindex]
                                              .skillCategoryId
                                              .toString() ==
                                          "3"
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CourseItem(
                                              name: _courseList[myindex].title,
                                              imageUrl: _courseList[myindex]
                                                  .titleImage,
                                              skillId: 3,
                                              noOfVideos: 6,
                                              skill: _courseList[myindex]
                                                  .skillCategoryId,
                                              // skill: skillsdevelopment[index],
                                            )
                                          ],
                                        )
                                      : Container();
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return CircularProgressIndicator(
                        color: Colors.red,
                      );
                    })

                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future loadData() async {
    Future.delayed(Duration(seconds: 1), () {
      getCourse();
      print("Rfreshed");
    });
    // return getData();
  }
}
