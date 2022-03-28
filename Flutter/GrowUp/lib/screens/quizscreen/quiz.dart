import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/models/quizmodel.dart';
import 'package:growup/services/apiservice.dart';

import '../../colorpalettes/palette.dart';

class QuizScreen extends StatefulWidget {
  var skillID;
  QuizScreen(this.skillID, {Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState(skillID);
}

class _QuizScreenState extends State<QuizScreen> {
  var skillID;
  _QuizScreenState(this.skillID);
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
    "a": Colors.white,
    "b": Colors.white,
    "c": Colors.white,
    "d": Colors.white,
  };
  checkAnswer(String k, String iscorrect) {
    if (iscorrect == "true") {
      btnColor[k] = Colors.green;
      marks = marks + 1;
      setState(() {});
      print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY$marks");
    } else {
      btnColor[k] = wrong;
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
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: FutureBuilder<List<Quiz>>(
              future: quiz,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData ||
                    snapshot.data != null ||
                    snapshot.connectionState == ConnectionState.done) {
                  List<Quiz> listQuiz = snapshot.data;
                  return PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        pageChanged = index;
                      });
                    },
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listQuiz.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listQuiz[index].text.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.8,
                            width: MediaQuery.of(context).size.width - 35,
                            // color: Colors.red,
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: listQuiz[index].options!.length,
                                  itemBuilder: (context, ansIndex) {
                                    k = ['a', 'b', 'c', 'd'];
                                    String selectedAns = listQuiz[index]
                                        .options![ansIndex]
                                        .isCorrectOption
                                        .toString();
                                    return Column(
                                      children: [
                                        choicebutton(
                                            k![ansIndex].toString(),
                                            listQuiz[index]
                                                .options![ansIndex]
                                                .text
                                                .toString(),
                                            selectedAns),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                          index == listQuiz.length - 1
                              ? ElevatedButton(
                                  onPressed: () {
                                    btnColor['a'] = Colors.white;
                                    btnColor['b'] = Colors.white;
                                    btnColor['c'] = Colors.white;
                                    btnColor['d'] = Colors.white;
                                    pageController.animateToPage(
                                      ++pageChanged,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.linear,
                                    );
                                    setState(() {});
                                    Get.to(QuizResultScreen(marks,
                                        listQuiz.length, widget.skillID));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: darkBlueColor,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      minimumSize: const Size(200, 60)),
                                  child: const Text(
                                    'Finish',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Raleway-Regular',
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    btnColor['a'] = Colors.white;
                                    btnColor['b'] = Colors.white;
                                    btnColor['c'] = Colors.white;
                                    btnColor['d'] = Colors.white;
                                    pageController.animateToPage(
                                      ++pageChanged,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.linear,
                                    );
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: darkBlueColor,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      minimumSize: const Size(200, 60)),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Raleway-Regular',
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                        ],
                      );
                    },
                  );
                }
                return Container();
              }),
        ),
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
                  return QuizScreen(widget.skillID);
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
