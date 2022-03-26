import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/screens/coursescreen/courseinfo.dart';
import 'package:growup/screens/profilescreen/profile_screen.dart';
import 'package:iconsax/iconsax.dart';

class CourseItem extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final int? noOfVideos;
  final int? skillId;
  var skill;

  CourseItem(
      {required this.name,
      required this.imageUrl,
      required this.noOfVideos,
      required this.skill,
      required this.skillId});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(
            "=====================================================================");
        print("YESSSSSSSSSSSS");
        // if(skill == "Development")
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseInfo(
                    name: name, imageUrl: imageUrl, skillId: skillId)));
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.6,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 14,
                  spreadRadius: 2,
                  offset: Offset(3, 3)),
            ]),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             //CourseInfoScreen()
                        //             CourseInfo(
                        //               name: name,
                        //               imageUrl: imageUrl,
                        //             )));
                      },
                      child: Container(
                        //margin: EdgeInsets.symmetric(horizontal: 20),
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //       color: Color(0xFF8A8A8A),
                          //       blurRadius: 14,
                          //       spreadRadius: 1,
                          //       offset: Offset(3, 3)),
                          // ],
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF90A5F8),
                              darkBlueColor,
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          //  color: Colors.red[300]
                        ),
                        child: Icon(
                          Iconsax.add,
                          color: Colors.white,
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    // color: Colors.red,
                    child: Image.network(
                      '$imageUrl',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              //color: Colors.green,
              child: Align(
                alignment: Alignment.center,
                child: Text("$name",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: blackTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    )),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text("$noOfVideos Videos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400))),
          ],
        ),
      ),
    );
  }
}
