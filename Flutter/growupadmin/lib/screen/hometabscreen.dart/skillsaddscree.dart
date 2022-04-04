import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growupadmin/apiservice/services.dart';
import 'package:growupadmin/colorpalettes/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

class SkillsAddScreen extends StatefulWidget {
  @override
  _SkillsAddScreenState createState() => _SkillsAddScreenState();
}

class _SkillsAddScreenState extends State<SkillsAddScreen> {
  var _image;
  final _currentItemSelected = 'Development';
  var selectedIndex;
  var catID;
  var skillID;
  final TextEditingController _titleControler = TextEditingController();
  Future CamaraImage() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera, maxWidth: 400, imageQuality: 100);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future GalleryImage() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 100);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width - 40,
              //color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Skill Courses",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    // height: 100,
                    width: MediaQuery.of(context).size.width - 80,
                    child: const Text(
                      "Add various skills category for students to learn according to thier choices",
                      style: TextStyle(
                          color: Color.fromARGB(255, 98, 98, 98),
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                FutureBuilder<List>(
                  future: getAllCat(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width - 40,
                        child: const Center(child: CircularProgressIndicator()),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(9)),
                            color: whiteColor,
                            border: Border.all(color: Colors.blueGrey)),
                      );
                    } else if (snapshot.hasData ||
                        snapshot.data != null ||
                        snapshot.connectionState == ConnectionState.done) {
                      List<String> categoryList = [];
                      int i = 0;
                      late List<String> nameList;
                      for (i = 0; i <= (snapshot.data!.length - 1); i++) {
                        categoryList.add(snapshot.data![i].name!);
                        nameList = categoryList;
                      }
                      print("*****************************************");
                      print(snapshot.data![0].name!);
                      return Column(
                        children: [
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(9)),
                                color: whiteColor,
                                border: Border.all(color: Colors.blueGrey)),
                            child: DropdownButton<String>(
                              // Step 3.
                              /// value: snapshot.data![0].name!,
                              value: snapshot.data![0].name!,
                              // Step 4.
                              items: nameList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }).toList(),
                              // Step 5.
                              onChanged: (String? newValue) {
                                setState(() {
                                  //_currentItemSelected = newValue!;
                                  // selectedIndex = nameList
                                  //     .indexOf(_currentItemSelected)
                                  //     .toString();
                                  // catID = snapshot
                                  //     .data![int.parse(selectedIndex)].id!
                                  //     .toString();
                                });
                                print("SELECTED ITEM:" + _currentItemSelected);
                                print("SELECTED INDEX:" +
                                    selectedIndex.toString());
                                print("CAT ID:" + catID.toString());
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: greyColor)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _titleControler,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Your skill course name',
                          hintStyle: TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(255, 130, 129, 129))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    GalleryImage();
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    color: Colors.blue.shade400,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: _image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Iconsax.folder_open,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select your file',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            )
                          : Image.file(
                              _image,
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9.8,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              CamaraImage();
                            },
                            child: const Icon(Iconsax.camera4),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              GalleryImage();
                            },
                            child: const Icon(Iconsax.gallery),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        width: 110,
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
                          onPressed: () async {
                            // await postSkills(catID, _titleControler.text, _image);
                            Fluttertoast.showToast(
                              msg: "Posted Successfully",
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            'Post',
                            style: whiteTextStyle.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
