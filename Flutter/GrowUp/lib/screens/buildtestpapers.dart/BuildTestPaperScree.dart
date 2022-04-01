import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/services/testpaperbuild.dart';

class BuildTestPaper extends StatefulWidget {
  const BuildTestPaper({Key? key}) : super(key: key);

  @override
  State<BuildTestPaper> createState() => _BuildTestPaperState();
}

class _BuildTestPaperState extends State<BuildTestPaper> {
  TextEditingController testController = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  var questions;
  final skills = [
    'The Complete Mobile Application Development',
    'Web Development Masterclass',
    'Ultimate Python Course',
    'Illustrator 2022 Masterclass',
    'Ultimate Adobe Photoshop',
    'Learn 3d Modelling',
    'Complete Digital Marketing Course',
    'Social Media Marketing 2022',
    'Ultimate Google Ads Training'
  ];
  var skillID;
  var _currentItemSelected = 'The Complete Mobile Application Development';
  getQuestion() async {
    questions = await getQuiz(skillID ?? 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkBlueColor,
          body: Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                width: MediaQuery.of(context).size.width - 50,
                // color: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [buildQuestion(), buildOptions()],
                )),
          )),
    );
  }

  Widget buildTextField(IconData? icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        decoration: InputDecoration(
          // labelText: "NabinGurung",
          errorText: null,
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 16, color: whiteColor),
        ),
      ),
    );
  }

  Widget buildQuestion() {
    return Column(
      children: [
        buildText("Choose Skill"),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          child: DropdownButton<String>(
            // Step 3.
            value: _currentItemSelected,
            // Step 4.
            items: <String>[
              'The Complete Mobile Application Development',
              'Web Development Masterclass',
              'Ultimate Python Course',
              'Illustrator 2022 Masterclass',
              'Ultimate Adobe Photoshop',
              'Learn 3d Modelling',
              'Complete Digital Marketing Course',
              'Social Media Marketing 2022',
              'Ultimate Google Ads Training'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
            // Step 5.
            onChanged: (String? newValue) {
              setState(() {
                _currentItemSelected = newValue!;
                if (newValue == skills[0]) {
                  setState(() {
                    skillID = 1;
                  });
                  print("ANDROID");
                } else if (newValue == skills[1]) {
                  setState(() {
                    skillID = 2;
                  });
                  print("WEB");
                } else if (newValue == skills[2]) {
                  setState(() {
                    skillID = 3;
                  });
                  print("GOOGLE");
                } else if (newValue == skills[3]) {
                  setState(() {
                    skillID = 4;
                  });
                  print("GOOGLE");
                } else if (newValue == skills[4]) {
                  setState(() {
                    skillID = 5;
                  });
                  print("GOOGLE");
                } else if (newValue == skills[5]) {
                  setState(() {
                    skillID = 6;
                  });
                  print("GOOGLE");
                } else if (newValue == skills[6]) {
                  setState(() {
                    skillID = 7;
                  });
                  print("GOOGLE");
                } else if (newValue == skills[7]) {
                  setState(() {
                    skillID = 8;
                  });
                  print("GOOGLE");
                } else if (newValue == skills[8]) {
                  setState(() {
                    skillID = 9;
                  });
                  print("GOOGLE");
                }
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        buildTextField(null, "Write your question here", false, false,
            testController, TextInputType.name),
        const SizedBox(
          height: 20,
        ),
        Container(
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
              10.0,
            ),
          ),
          child: FlatButton(
            onPressed: () async {
              // await getQuestion();
              await getQuestion();
              var l = await questions.length;
              var finalIndex = l - (l - 1);
              print("************FINAL INDEX*********************");
              print(finalIndex);
              bool added =
                  await postQuestion(skillID.toString(), testController.text);
              added
                  ? Fluttertoast.showToast(
                      msg: "Question has been added successfully",
                    )
                  : Fluttertoast.showToast(
                      msg: "Question cannot be added.SORRY!!",
                    );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: Text(
              'Add Question',
              style: whiteTextStyle.copyWith(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildText(String name) {
    return Text(
      name,
      style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 20,
          fontWeight: FontWeight.bold),
    );
  }

  Widget buildOptions() {
    return Column(
      children: [
        buildTextField(
            null, "Option1", false, false, option1, TextInputType.name),
        buildTextField(
            null, "Option1", false, false, option2, TextInputType.name),
        buildTextField(
            null, "Option1", false, false, option3, TextInputType.name),
        buildTextField(
            null, "Option1", false, false, option4, TextInputType.name),
        Container(
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
              10.0,
            ),
          ),
          child: FlatButton(
            onPressed: () async {
              await getQuestion();
              var l = await questions.length;
              var finalIndex = l - 1;
              print("************FINAL INDEX*********************");
              print(finalIndex);
              var questionIndex = await questions[finalIndex].id;
              print("**************QUESTION INDEX*******************");
              print(finalIndex);
              postOptions(questionIndex, option1.text, false);
              postOptions(questionIndex, option2.text, false);
              postOptions(questionIndex, option3.text, true);
              bool added =
                  await postOptions(questionIndex, option4.text, false);

              added
                  ? Fluttertoast.showToast(
                      msg: "Options has been added successfully",
                    )
                  : Fluttertoast.showToast(
                      msg: "Options cannot be added.SORRY!!",
                    );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: Text(
              'Add Options',
              style: whiteTextStyle.copyWith(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
