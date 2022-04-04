import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:growupadmin/apiservice/services.dart';
import 'package:growupadmin/apiservice/videoaddservices.dart';
import 'package:growupadmin/colorpalettes/palette.dart';
import 'package:growupadmin/models/media_source.dart';
import 'package:growupadmin/models/skillsdetailmodel.dart';
import 'package:growupadmin/screen/videoPostScreen.dart/source_page.dart';
import 'package:growupadmin/screen/videoPostScreen.dart/video_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

class SkillVideoPost extends StatefulWidget {
  @override
  _SkillVideoPostState createState() => _SkillVideoPostState();
}

class _SkillVideoPostState extends State<SkillVideoPost> {
  AudioCache? _audioCache;
  var _image;
  File? fileMedia;
  MediaSource? source;
  bool isPosted = false;
  var skillID;
  var selectedIndex;
  var _currentItemSelected = 'The Complete Mobile Application Development';
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

  Future<List<SkillsDetailModel>>? _skillsDetail;
  @override
  void initState() {
    super.initState();
    _skillsDetail = getSkillDetails();
    _audioCache = AudioCache(
      prefix: 'audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: TeacherDrawerScreen(),
      backgroundColor: const Color.fromARGB(255, 216, 222, 255),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 30,
              // child: IconButton(
              //     onPressed: () {
              //       _audioCache!.play("sounds/downloadsound.mp3");
              //     },
              //     icon: const Icon(Icons.place)),
            ),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: whiteColor,
              ),
              child: FutureBuilder<List<SkillsDetailModel>>(
                future: _skillsDetail,
                builder: (context, snapshot) {
                  if (snapshot.data == null ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(9)),
                          color: whiteColor,
                          border: Border.all(color: Colors.blueGrey)),
                      child: Center(
                          child:
                              CircularProgressIndicator(color: darkBlueColor)),
                    );
                  } else if (snapshot.hasData ||
                      snapshot.data != null ||
                      snapshot.connectionState == ConnectionState.done) {
                    var skillsData = snapshot.data!;

                    List<String> skillNameList = [];
                    int i = 0;
                    late List<String> nameList;
                    for (i = 0; i <= (skillsData.length - 1); i++) {
                      skillNameList.add(skillsData[i].title!);
                      nameList = skillNameList;
                    }
                    return Container(
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
                        value: snapshot.data![0].title!,
                        // Step 4.
                        items: nameList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            _currentItemSelected = newValue!;
                            selectedIndex = nameList
                                .indexOf(_currentItemSelected)
                                .toString();
                            skillID = snapshot
                                .data![int.parse(selectedIndex)].id!
                                .toString();
                          });

                          print("SELECTED INDEX:" + selectedIndex);
                          print("SELECTED SKILL ID:" + skillID);
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 45,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.blueGrey)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: _titleControler,
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add your title',
                      hintStyle:
                          TextStyle(fontSize: 19, color: Colors.blueGrey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: Colors.blue.shade400,
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: fileMedia == null
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
                              'Upload skill videos',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade400),
                            ),
                          ],
                        )
                      : (source == MediaSource.image
                          ? Image.file(
                              fileMedia!,
                              fit: BoxFit.contain,
                            )
                          : VideoWidget(
                              fileMedia!,
                            )),
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      capture(MediaSource.video);
                    },
                    child: const Icon(Iconsax.video),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: !isPosted ? 110 : 180,
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
                          isPosted = true;
                          setState(() {});
                          var id = skillID;
                          await postSkillsVideo(
                              id.toString(), _titleControler.text, fileMedia!);
                          isPosted = false;
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: !isPosted
                            ? Text(
                                'Post',
                                style: whiteTextStyle.copyWith(fontSize: 18),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Uploading...',
                                    style:
                                        whiteTextStyle.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ],
                              )),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      fileMedia = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}
