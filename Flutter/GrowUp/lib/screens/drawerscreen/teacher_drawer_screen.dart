import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/controller/myController.dart';
import 'package:growup/controller/tutorcontroller.dart';
import 'package:growup/screens/learninganalysisscreen/learninganalysispage.dart';
import 'package:growup/screens/profilescreen/profile_screen.dart';
import 'package:growup/screens/profilescreen/teacher_profile_screen.dart';
import 'package:growup/screens/teacherscreen/bookclasses.dart';
import 'package:growup/screens/tutorscreen/tutorlist.dart';
import 'package:growup/services/apiservice.dart';
import 'package:iconsax/iconsax.dart';

class TeacherDrawerScreen extends StatefulWidget {
  @override
  _TeacherDrawerScreenState createState() => _TeacherDrawerScreenState();
}

class _TeacherDrawerScreenState extends State<TeacherDrawerScreen> {
  bool isSwitched = false;
  final switchController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    return Container(
      width: 250,
      color: darkBlueColor,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            //  BoxFit.cover,
                            "https://i.pinimg.com/originals/c8/f1/46/c8f14613fdfd69eaced69d0f1143d47d.jpg")),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FutureBuilder<dynamic>(
                  future:
                      getUserDetails("0c188464-ba3d-4493-ac40-1ab1de31178c"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //userFinalDetails!.fullName.toString()
                      var name = snapshot.data!.fullName.toString();
                      var email = snapshot.data!.userName.toString();
                      return Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(.8),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        "No ratings",
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
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherProfile(),
                        ));
                  },
                  child: NewRow(
                    text: 'Profile',
                    icon: Iconsax.personalcard,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearningAnalysisPage(),
                      )),
                  child: NewRow(
                    text: 'Build Test Paper',
                    icon: Iconsax.receipt,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookedClasses(),
                      )),
                  child: NewRow(
                    text: 'Booked Classes',
                    icon: Iconsax.bookmark,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Terms & Condition',
                  icon: Iconsax.note,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'App Mode',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Obx(() {
                      return Switch(
                        value: switchController.isOn.value,
                        onChanged: (value) {
                          // setState(() {
                          //   isSwitched = value;
                          //   value = false;
                          //   // print(isSwitched);
                          // });
                          switchController.isOn.toggle();
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      );
                    }),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Log out',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData? icon;
  final String? text;

  const NewRow({
    Key? key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Color(0xfff85c0b)),
        SizedBox(
          width: 20,
        ),
        Text(
          text!,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
