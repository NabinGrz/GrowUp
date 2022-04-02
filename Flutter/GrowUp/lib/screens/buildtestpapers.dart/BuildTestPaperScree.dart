import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/exammodel.dart';
import 'package:growup/services/testExamservices.dart';
import 'package:growup/widgets/shimmer.dart';

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
  List<ExamModel>? examList;
  var skillID = [];
  var selectedIndex;
  var examID;
  var _currentItemSelected;
  bool options = false;
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  Future getAllData() async {
    // do the api stuff
    examList = await getAllExamList();
    _currentItemSelected = examList![0].name;
    setState(() {});
    return examList![0].name;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllExamList();
    options = true;
    setState(() {});
    //  getExam();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkBlueColor,
          body: Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 0.7,
                width: MediaQuery.of(context).size.width - 50,
                // color: Colors.grey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [buildQuestion(), buildOptions()],
                  ),
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
        GestureDetector(
            onTap: () async {
              var d = await getAllTestofExam(int.parse(examID));
              print(d);
            },
            child: buildText("Choose Skill")),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder<List<ExamModel>>(
          future: getAllExamList(),
          builder: (context, snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerEffect(
                  context,
                  const SizedBox(
                    height: 30,
                    width: 60,
                  ));
            } else if (snapshot.hasData ||
                snapshot.data != null ||
                snapshot.connectionState == ConnectionState.done) {
              List<String> examNameList = [];
              int i = 0;
              late List<String> nameList;
              for (i = 0; i <= (snapshot.data!.length - 1); i++) {
                examNameList.add(snapshot.data![i].name!);
                nameList = examNameList;
              }
              return Container(
                color: Colors.white,
                child: DropdownButton<String>(
                  // Step 3.
                  value: snapshot.data![0].name!,
                  // Step 4.
                  items: nameList.map<DropdownMenuItem<String>>((String value) {
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
                      selectedIndex =
                          nameList.indexOf(_currentItemSelected).toString();
                      examID = snapshot.data![int.parse(selectedIndex)].id!
                          .toString();
                    });
                    print("SELECTED:" + _currentItemSelected);
                    print("SELECTED:" + selectedIndex);
                    print("EXAM ID:" + examID.toString());
                  },
                ),
              );
            }
            return Container();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        buildTextField(null, "Write your question here", false, false,
            testController, TextInputType.name),
        const SizedBox(
          height: 20,
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextField(
              null, "Option1", false, false, option1, TextInputType.name),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue1,
              onChanged: (newValue) {
                setState(() {
                  checkedValue1 = newValue!;
                });
                print("*********************************************");
                print(checkedValue1);
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          buildTextField(
              null, "Option1", false, false, option2, TextInputType.name),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue2,
              onChanged: (newValue) {
                setState(() {
                  checkedValue2 = newValue!;
                  print("*********************************************");
                  print(checkedValue2);
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          buildTextField(
              null, "Option1", false, false, option3, TextInputType.name),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue3,
              onChanged: (newValue) {
                setState(() {
                  checkedValue3 = newValue!;
                  print("*********************************************");
                  print(checkedValue3);
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          buildTextField(
              null, "Option1", false, false, option4, TextInputType.name),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue4,
              onChanged: (newValue) {
                setState(() {
                  checkedValue4 = newValue!;
                  print("*********************************************");
                  print(checkedValue4);
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
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
                  options = false;
                  setState(() {});
                  var data = await getAllTestofExam(int.parse(examID));
                  var l = data.length;
                  print("************LENGTH********************");
                  print(l);

                  // var l = await questions.length;
                  // var finalIndex = l - 1;

                  bool posted = await postTest(testController.text, examID);

                  if (posted) {
                    var d = await getAllTestofExam(int.parse(examID));
                    var l = d.length;
                    print("************LENGTH********************");
                    print(l);
                    var finalIndex = l - 1;
                    var testIndex = d[finalIndex].id;
                    print("**************TEST INDEX*******************");

                    print(testIndex);
                    // print("************2LENGTH********************");
                    // print(l);
                    await postTestOptions(
                        option1.text, testIndex.toString(), checkedValue1);
                    await postTestOptions(
                        option2.text, testIndex.toString(), checkedValue2);
                    await postTestOptions(
                        option3.text, testIndex.toString(), checkedValue3);
                    options = await postTestOptions(
                        option4.text, testIndex.toString(), checkedValue4);
                    setState(() {});
                    options
                        ? Fluttertoast.showToast(
                            msg: "Test has been added successfully",
                          )
                        : Fluttertoast.showToast(
                            msg: "Test cannot be added.SORRY!!",
                          );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                child: options
                    ? Text(
                        'Add Test',
                        style: whiteTextStyle.copyWith(fontSize: 18),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      )),
          ),
        ],
      ),
    );
  }
}
