import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growupadmin/apiservice/services.dart';
import 'package:growupadmin/colorpalettes/palette.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController skillName = TextEditingController();
  bool skillAdded = false;
  String errorMsg = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          left: MediaQuery.of(context).size.width -
              (MediaQuery.of(context).size.width - 30),
          top: MediaQuery.of(context).size.height / 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Skills Category",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width - 80,
                child: const Text(
                  "Add various skill category for students to learn according to thier choice and interest",
                  style: TextStyle(
                      color: Color.fromARGB(255, 98, 98, 98),
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 14,
                      spreadRadius: 2,
                      offset: Offset(3, 3)),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      buildTextField(Icons.category, "Skill Name", false, true,
                          skillName, TextInputType.name),
                      Text(
                        errorMsg,
                        style: const TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
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
                      15.0,
                    ),
                  ),
                  child: FlatButton(
                      onPressed: () async {
                        skillAdded = true;
                        setState(() {});

                        if (skillName.text.isNotEmpty) {
                          var skill = await postSkillCategory(skillName.text);
                          if (skill) {
                            Fluttertoast.showToast(
                              msg: "Skill has been added",
                            );
                            skillAdded = false;
                            errorMsg = "";
                            errorMsg = "";
                            setState(() {});
                          } else {
                            skillAdded = false;
                            errorMsg = "";
                            setState(() {});
                            Fluttertoast.showToast(
                              msg: "Skill cannot be added",
                            );
                          }
                        } else {
                          skillAdded = false;
                          errorMsg = "Skill name is required";
                          setState(() {});
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: !skillAdded
                          ? Text(
                              'Add Skill Category',
                              style: whiteTextStyle.copyWith(fontSize: 18),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            )),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

//TEXTFIELD WIDGET

  Widget buildTextField(IconData icon, String hintText, bool isPassword,
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

          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: blackColor),
          //   borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: darkBlueColor),
          //   borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          // ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.blueGrey),
        ),
      ),
    );
  }
}
