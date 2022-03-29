import 'dart:io';

import 'package:flutter/material.dart';
import 'package:growup/models/quizmodel.dart';
import 'package:growup/services/apiservice.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import '../../colorpalettes/palette.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
  @override
  var quiz;
  List<String>? k;
  Color answerBoxColors = Colors.white;
  Color correct = Colors.green;
  Color wrong = Colors.red;
  Color notselected = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz = getQuiz(widget.skillID);
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
    "a": 60,
    "b": 60,
    "c": 60,
    "d": 60,
  };
  Map<String, double> btnWidth = {
    "a": 400,
    "b": 400,
    "c": 400,
    "d": 400,
  };
  Map<String, double> btnTextSize = {
    "a": 16,
    "b": 16,
    "c": 16,
    "d": 16,
  };
  double buttonH = 60;
  double buttonW = 400;
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
                          //             rlistQuiz[index]
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
                        // index == listQuiz.length - 1

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
      btnHeight[k] = 65;
      btnWidth[k] = 450;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 20;
      marks = marks + 1;

      setState(() {});
      print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY$marks");
    } else {
      btnColor[k] = wrong;
      btnHeight[k] = 65;
      btnWidth[k] = 450;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 20;
      marks = marks;
      setState(() {});
      print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$marks");
    }
  }

  giveMessage(int index) {
    String message = "Correct Answer";
    return message;
  }

  Widget choicebutton(String k, String text, String isCorrect) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          checkAnswer(k, isCorrect);
          print("K IS: $k");
        },
        child: Text(
          text,
          style: TextStyle(
            color: btnTextColor[k],
            fontFamily: "Alike",
            fontSize: btnTextSize[k],
          ),
          maxLines: 1,
        ),
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
        body: FutureBuilder<List<Quiz>>(
            future: quiz,
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData ||
                  snapshot.data != null ||
                  snapshot.connectionState == ConnectionState.done) {
                List<Quiz> listQuiz = snapshot.data;
                List<Quiz> rlistQuiz = listQuiz.reversed.toList();
                return ListView.builder(
                  // controller: pageController,
                  // physics: const NeverScrollableScrollPhysics(),
                  // reverse: true,
                  itemCount: rlistQuiz.length,
                  itemBuilder: (context, index) {
                    k = ['a', 'b', 'c', 'd'];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: Text(
                            rlistQuiz[index].text.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          //color: Colors.red,
                          // width: 500,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          height: 130,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 60,
                              childAspectRatio: 3.3,
                            ),
                            itemBuilder: (context, ansIndex) {
                              int i = ansIndex + 1;
                              return Container(
                                child: Text(
                                  "$i. " +
                                      rlistQuiz[index]
                                          .options![ansIndex]
                                          .text
                                          .toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                            },
                            itemCount: 4,
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                          width: 500,
                          child: Divider(
                            thickness: 0.9,
                            color: Colors.grey,
                          ),
                        ),
                        // index == listQuiz.length - 1
                        //     ? ElevatedButton(
                        //         onPressed: () {
                        //           Get.to(QuizResultScreen(marks,
                        //               listQuiz.length, widget.skillID));
                        //         },
                        //         style: ElevatedButton.styleFrom(
                        //             primary: darkBlueColor,
                        //             elevation: 10,
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(17),
                        //             ),
                        //             minimumSize: const Size(200, 60)),
                        //         child: const Text(
                        //           'Finish',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontFamily: 'Raleway-Regular',
                        //               fontWeight: FontWeight.w700),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       )
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
                );
              }
              return Container();
            }),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     generateFile();
        //   },
        //   child: const Icon(Iconsax.document_download),
        // ),
      ),
    );
  }
}

class QuizResultScreen extends StatefulWidget {
  static const routeName = '/quizResult';
  var marks;
  var questionNumber;
  var skillID;
  QuizResultScreen(this.marks, this.questionNumber, this.skillID, {Key? key})
      : super(key: key);

  @override
  _QuizResultScreenState createState() =>
      _QuizResultScreenState(marks, questionNumber, skillID);
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  var marks;
  var questionNumber;
  var skillID;
  _QuizResultScreenState(this.marks, this.questionNumber, this.skillID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //  decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizResultInfo(marks, questionNumber),
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
          //     //     context, QuizHistoryScreen.routeName);
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

  Widget quizResultInfo(var marks, int questionNumber) {
    return Column(
      children: [
        Image.asset(
          'images/quizResultBadge.png',
          //width: 130,
        ),
        Text(
          "Congratulations!",
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "You have completed the quiz",
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
