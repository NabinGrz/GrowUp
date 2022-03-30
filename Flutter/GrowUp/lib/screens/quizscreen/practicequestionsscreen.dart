import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:growup/models/practicemodel.dart';
import 'package:growup/screens/homescreen/homepage_screen.dart';
import 'package:growup/services/apipractice.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import '../../colorpalettes/palette.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

_showModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.4,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xffFFFFFF),
            // borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Iconsax.box_remove,
                size: 120,
                color: Colors.red,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "End practice session?",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Are you sure you want to exit the practice session?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 66, 66, 66)),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  //print("Time is:" + timer.toString());
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: darkBlueColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(150, 60)),
                child: const Text(
                  'Resume',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Raleway-Regular',
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const HomePageScreen());
                },
                child: SizedBox(
                  height: 40,
                  child: Text(
                    "Quit",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: darkBlueColor),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

class PracticeQuestionScreen extends StatefulWidget {
  var skillID;
  PracticeQuestionScreen(this.skillID, {Key? key}) : super(key: key);

  @override
  State<PracticeQuestionScreen> createState() =>
      _PracticeQuestionScreenState(skillID);
}

class _PracticeQuestionScreenState extends State<PracticeQuestionScreen> {
  var skillID;
  _PracticeQuestionScreenState(this.skillID);
  bool isClicked = false;
  @override
  var practiceQuestions;
  List<String>? k;
  int timer = 0;
  String showtimer = "0";
  Color answerBoxColors = Colors.white;
  Color correct = Colors.green;
  Color wrong = Colors.red;
  bool canceltimer = false;
  Color notselected = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starttimer();
    // practiceQuestions = getPractice(widget.skillID);
    practiceQuestions = getPracticeQuestions();
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        // if (timer < 1) {
        //   t.cancel();
        //   nextPage();
        // } else if (canceltimer == true) {
        //   t.cancel();
        if (timer == 90) {
        } else {
          timer = timer + 1;
        }
        showtimer = timer.toString().length == 2
            ? timer.toString()
            : "0" + timer.toString();
      });
    });
  }

  void nextPage() {
    pageController.animateToPage(
      ++pageChanged,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }

  PageController pageController = PageController();
  int pageChanged = 0;
  double marks = 0.0;
  double finalMarks = 0.0;
  Map<String, Color> btnColor = {
    "a": const Color.fromARGB(255, 230, 230, 230),
    "b": const Color.fromARGB(255, 230, 230, 230),
    "c": const Color.fromARGB(255, 230, 230, 230),
    "d": const Color.fromARGB(255, 230, 230, 230),
  };
  Map<String, Color> btnTextColor = {
    "a": const Color.fromARGB(255, 0, 0, 0),
    "b": const Color.fromARGB(255, 0, 0, 0),
    "c": const Color.fromARGB(255, 0, 0, 0),
    "d": const Color.fromARGB(255, 0, 0, 0),
  };

  Map<String, double> btnHeight = {
    "a": 20,
    "b": 20,
    "c": 20,
    "d": 20,
  };
  Map<String, double> btnWidth = {
    "a": 20,
    "b": 20,
    "c": 20,
    "d": 20,
  };
  Map<String, double> btnTextSize = {
    "a": 16,
    "b": 16,
    "c": 16,
    "d": 16,
  };
  double buttonH = 20;
  double buttonW = 20;
  // a dcoument variable decalration
  final doc = pw.Document();

  void generateFile(var l) async {
    doc.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Center(
                    child: pw.ListView.builder(
                  // controller: pageController,
                  // physics: const NeverScrollableScrollPhysics(),
                  // reverse: true,
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    k = ['a', 'b', 'c', 'd'];
                    return pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 20.0, top: 15),
                          child: pw.Text(
                            l[index].text.toString(),
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Container(
                          //color: Colors.red,
                          // width: 500,
                          margin: const pw.EdgeInsets.symmetric(horizontal: 30),
                          height: 130,
                          // child:
                          //  GridView.builder(
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   gridDelegate:
                          //       const SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2,
                          //     mainAxisSpacing: 12,
                          //     crossAxisSpacing: 60,
                          //     childAspectRatio: 3.3,
                          //   ),
                          //   itemBuilder: (context, ansIndex) {
                          //     int i = ansIndex + 1;
                          //     return Container(
                          //       child: Text(
                          //         "$i. " +
                          //             rlistPractice[index]
                          //                 .options![ansIndex]
                          //                 .text
                          //                 .toString(),
                          //         style: const TextStyle(
                          //             fontSize: 15,
                          //             fontWeight: FontWeight.w400),
                          //       ),
                          //     );
                          //   },
                          //   itemCount: 4,
                          // ),
                        ),
                        pw.SizedBox(
                          height: 35,
                          width: 500,
                          child: pw.Divider(
                            thickness: 0.9,
                          ),
                        ),
                        // index == listPractice.length - 1

                        //     : ElevatedButton(
                        //         onPressed: () {
                        //           btnColor['a'] = const Color.fromARGB(
                        //               255, 230, 230, 230);
                        //           btnHeight['a'] = 60;
                        //           btnWidth['a'] = 400;
                        //           btnTextColor['a'] = Colors.black;
                        //           btnTextSize['a'] = 16;
                        //           btnColor['b'] = const Color.fromARGB(
                        //               255, 230, 230, 230);
                        //           btnHeight['b'] = 60;
                        //           btnWidth['b'] = 400;
                        //           btnTextColor['b'] = Colors.black;
                        //           btnTextSize['b'] = 16;
                        //           btnColor['c'] = const Color.fromARGB(
                        //               255, 230, 230, 230);
                        //           btnHeight['c'] = 60;
                        //           btnWidth['c'] = 400;
                        //           btnTextColor['c'] = Colors.black;
                        //           btnTextSize['c'] = 16;
                        //           btnColor['d'] = const Color.fromARGB(
                        //               255, 230, 230, 230);
                        //           btnHeight['d'] = 60;
                        //           btnWidth['d'] = 400;
                        //           btnTextColor['d'] = Colors.black;
                        //           btnTextSize['d'] = 16;
                        //           pageController.animateToPage(
                        //             ++pageChanged,
                        //             duration:
                        //                 const Duration(milliseconds: 250),
                        //             curve: Curves.linear,
                        //           );
                        //           setState(() {});
                        //         },
                        //         style: ElevatedButton.styleFrom(
                        //             primary: darkBlueColor,
                        //             elevation: 10,
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(17),
                        //             ),
                        //             minimumSize: const Size(200, 60)),
                        //         child: const Text(
                        //           'Next',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontFamily: 'Raleway-Regular',
                        //               fontWeight: FontWeight.w700),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       )
                      ],
                    );
                  },
                )),
              ],
            );
          }),
    );

    final outPut = await getExternalStorageDirectory();

    String path = outPut!.path + '/nabin.pdf';
    final file = File(path);
    file.writeAsBytesSync(List.from(await doc.save()));
    print("*****************************************");
    print(outPut.path);
  }

  checkAnswer(String k, String iscorrect) {
    if (iscorrect == "true") {
      btnColor[k] = Colors.green;
      btnHeight[k] = 23;
      btnWidth[k] = 23;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 23;
      marks = marks + 1;

      setState(() {});
      print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY$marks");
    } else {
      btnColor[k] = wrong;
      btnHeight[k] = 23;
      btnWidth[k] = 23;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 23;
      marks = marks;
      setState(() {});
      print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$marks");
    }
  }

  giveMessage(int index) {
    String message = "Correct Answer";
    return message;
  }

  Widget choicebutton(String k, String isCorrect) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          checkAnswer(k, isCorrect);
          print("K IS: $k");
          setState(() {
            isClicked = true;
          });
        },
        child: Container(),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: btnWidth[k],
        height: btnHeight[k],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: FutureBuilder<List<Practice>>(
            future: practiceQuestions,
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData ||
                  snapshot.data != null ||
                  snapshot.connectionState == ConnectionState.done) {
                List<Practice> listPractice = snapshot.data;
                return PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      pageChanged = index;
                    });
                  },
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listPractice.length,
                  itemBuilder: (context, index) {
                    var num = index + 1;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            //color: Colors.red,
                            width: MediaQuery.of(context).size.width - 17,
                            height: MediaQuery.of(context).size.height * 0.11,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "00:" + showtimer,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showModalBottomSheet(context);
                                  },
                                  child: const Text(
                                    "END",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 111, 115, 143),
                                    blurRadius: 14,
                                    spreadRadius: 1,
                                    offset: Offset(3, 3)),
                              ]),
                          height: MediaQuery.of(context).size.height / 2.1,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Question $num",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        listPractice[index].text.toString(),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 3.4,
                                width: MediaQuery.of(context).size.width - 35,
                                // color: Colors.red,
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          listPractice[index].options!.length,
                                      itemBuilder: (context, ansIndex) {
                                        k = ['a', 'b', 'c', 'd'];
                                        String selectedAns = listPractice[index]
                                            .options![ansIndex]
                                            .isCorrectOption
                                            .toString();
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                choicebutton(
                                                    k![ansIndex].toString(),
                                                    selectedAns),
                                                SizedBox(
                                                  //color: Colors.red,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      150,
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0),
                                                    child: Text(
                                                      listPractice[index]
                                                          .options![ansIndex]
                                                          .text
                                                          .toString(),
                                                      //textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        isClicked
                            ? index == listPractice.length - 1
                                ? Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
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
                                      onPressed: () {
                                        Get.to(const HomePageScreen());
                                        Fluttertoast.showToast(
                                          msg:
                                              "Good jon you have cleard the practice",
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      child: Text(
                                        'Finish',
                                        style: whiteTextStyle.copyWith(
                                            fontSize: 18),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
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
                                      onPressed: () {
                                        btnColor['a'] = const Color.fromARGB(
                                            255, 230, 230, 230);
                                        btnHeight['a'] = 23;
                                        btnWidth['a'] = 23;
                                        btnTextColor['a'] = Colors.black;
                                        btnTextSize['a'] = 16;
                                        btnColor['b'] = const Color.fromARGB(
                                            255, 230, 230, 230);
                                        btnHeight['b'] = 23;
                                        btnWidth['b'] = 23;
                                        btnTextColor['b'] = Colors.black;
                                        btnTextSize['b'] = 16;
                                        btnColor['c'] = const Color.fromARGB(
                                            255, 230, 230, 230);
                                        btnHeight['c'] = 23;
                                        btnWidth['c'] = 23;
                                        btnTextColor['c'] = Colors.black;
                                        btnTextSize['c'] = 16;
                                        btnColor['d'] = const Color.fromARGB(
                                            255, 230, 230, 230);
                                        btnHeight['d'] = 23;
                                        btnWidth['d'] = 23;
                                        btnTextColor['d'] = Colors.black;
                                        btnTextSize['d'] = 16;
                                        nextPage();

                                        setState(() {
                                          isClicked = false;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      child: Text(
                                        'Submit',
                                        style: whiteTextStyle.copyWith(
                                            fontSize: 18),
                                      ),
                                    ),
                                  )
                            : Container()
                      ],
                    );
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}

class PracticeResultScreen extends StatefulWidget {
  static const routeName = '/practiceQuestionsResult';
  var marks;
  var questionNumber;
  var skillID;
  PracticeResultScreen(this.marks, this.questionNumber, this.skillID,
      {Key? key})
      : super(key: key);

  @override
  _PracticeResultScreenState createState() =>
      _PracticeResultScreenState(marks, questionNumber, skillID);
}

class _PracticeResultScreenState extends State<PracticeResultScreen> {
  var marks;
  var questionNumber;
  var skillID;
  _PracticeResultScreenState(this.marks, this.questionNumber, this.skillID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //  decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            practiceQuestionsResultInfo(marks, questionNumber),
            bottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PracticeQuestionScreen(widget.skillID);
                },
              ));
            },
            style: ElevatedButton.styleFrom(
                primary: darkBlueColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                minimumSize: const Size(200, 60)),
            child: const Text(
              "Try Again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigator.pushReplacementNamed(
          //     //     context, PracticeHistoryScreen.routeName);
          //   },
          //   child: Text(
          //     "History",
          //     style: TextStyle(color: Colors.white, fontSize: 20),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget practiceQuestionsResultInfo(var marks, int questionNumber) {
    return Column(
      children: [
        Image.asset(
          'images/practiceQuestionsResultBadge.png',
          //width: 130,
        ),
        Text(
          "Congratulations!",
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "You have completed the practiceQuestions",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          "Your Score",
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "$marks/$questionNumber",
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
