import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/services/testExamservices.dart';

class BuildExamScreen extends StatefulWidget {
  const BuildExamScreen({Key? key}) : super(key: key);

  @override
  State<BuildExamScreen> createState() => _BuildExamScreenState();
}

class _BuildExamScreenState extends State<BuildExamScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController tutorNameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
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
  var _currentDiff = 'Easy';
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkBlueColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              buildTextField(null, "Test Name", false, false, nameController,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: DropdownButton<String>(
                  // Step 3.
                  value: _currentDiff,
                  // Step 4.
                  items: <String>['Easy', 'Medium', 'Hard']
                      .map<DropdownMenuItem<String>>((String value) {
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
                    _currentDiff = newValue!;
                    setState(() {});
                  },
                ),
              ),
              buildTextField(null, "Tutor Name", false, false,
                  tutorNameController, TextInputType.name),
              buildTextField(null, "Total No.of Questions", false, false,
                  questionController, TextInputType.name),
              buildButton()
            ],
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

  Widget buildButton() {
    return Container(
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
          // await getQuestion();
          // var l = await questions.length;
          // var finalIndex = l - (l - 1);
          // print("************FINAL INDEX*********************");
          // print(finalIndex);
          /**
                "SkillId": skillId,
                      "Name": name,
                      "Difficulty": difficulty,
                      "TutorName": tutorname,
                      "TotalQuestions": totalquestions
     */
          bool added = await postExam(skillID.toString(), nameController.text,
              _currentDiff, tutorNameController.text, questionController.text);
          added
              ? Fluttertoast.showToast(
                  msg: "Exam has been created successfully",
                )
              : Fluttertoast.showToast(
                  msg: "Exam cannot be added.SORRY!!",
                );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        child: Text(
          'Add Exam',
          style: whiteTextStyle.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
