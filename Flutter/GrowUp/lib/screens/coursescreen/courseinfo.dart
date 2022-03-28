import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/downloads/download.dart';
import 'package:growup/downloads/download_provider.dart';
import 'package:growup/models/skillsvideoresponsemodel.dart';
import 'package:growup/screens/quizscreen/quiz.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/widgets/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:math';

class CourseInfo extends StatefulWidget {
  var name;
  var imageUrl;
  var skillId;
  CourseInfo(
      {required this.name, required this.imageUrl, required this.skillId});

  @override
  _CourseInfoState createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();
  var _dataVideos;
  double padding = 20;
  bool _playArea = false;
  bool _isPlaying = false;
  final bool _disposed = false;
  List<SkillsVideoResponseModel>? _videosList;
  int _isPlayingIndex = -1;
  VideoPlayerController? _controller;
  int tappedIndex = 0;
  final snackBar = SnackBar(
    content: const Text(
        'Your files will be downloaded in "Download" folder of your device'),
    backgroundColor: Colors.black,
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );

  @override
  void initState() {
    _dataVideos = getSkillVideos(widget.skillId);
    _scrollController.addListener(() {
      setState(() {
        padding = _isSliverAppBarExpanded ? padding = 50 : padding = 20;
      });
    });
    super.initState();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    // if (down == "Downloading... 100%") {
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    print("||||||||||||||||||||||||||||||||||||||||||||||||");
    var fileDownloaderProvider =
        Provider.of<FileDownloaderProvider>(context, listen: false);
    // print(widget.skills.toString());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            !_playArea
                ? Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // borderRadius:
                          //    BorderRadius.only(bottomRight: Radius.circular(50)),
                          gradient: LinearGradient(
                              colors: [
                                darkBlueColor,
                                const Color(0xFF8897F7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 8),
                                child: Text(
                                  widget.name,
                                  //  "Check",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            Hero(
                                tag: "imageUrl",
                                //  tag: "check",
                                child: !_isSliverAppBarExpanded
                                    ? Align(
                                        alignment: Alignment.bottomRight,
                                        child: Image.network(
                                          widget.imageUrl,
                                          // "images/pngg.png",
                                          height: 300,
                                          width: 300,
                                          // fit: BoxFit.contain,
                                        ),
                                      )
                                    : Container()),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    // height: 300,
                    // width: 300,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          color: darkBlueColor,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    //Naviga
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            _playView(context),
                            Positioned(
                              bottom: 10,
                              child: SizedBox(
                                //  color: Colors.yellow,
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Colors.red[700],
                                      inactiveTrackColor: Colors.red[100],
                                      trackShape:
                                          const RoundedRectSliderTrackShape(),
                                      trackHeight: 1.5,
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 7.0),
                                      thumbColor: Colors.redAccent,
                                      overlayColor: Colors.red.withAlpha(32),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                              overlayRadius: 28.0),
                                      tickMarkShape:
                                          const RoundSliderTickMarkShape(),
                                      activeTickMarkColor: Colors.red[700],
                                      inactiveTickMarkColor: Colors.red[100],
                                      valueIndicatorShape:
                                          const PaddleSliderValueIndicatorShape(),
                                      valueIndicatorColor: Colors.redAccent,
                                      valueIndicatorTextStyle: const TextStyle(
                                        color: Colors.white,
                                      ), // TextStyle
                                    ),
                                    child: Slider(
                                        value:
                                            max(0, min(_progress * 100, 100)),
                                        min: 0,
                                        max: 100,
                                        divisions: 100,
                                        label:
                                            _position?.toString().split(".")[0],
                                        onChanged: (value) {
                                          setState(() {
                                            _progress = value * 0.01;
                                          });
                                        },
                                        onChangeStart: (value) {
                                          _controller?.pause();
                                        },
                                        onChangeEnd: (value) {
                                          final duration =
                                              _controller?.value.duration;
                                          if (duration != null) {
                                            var newValue =
                                                max(0, min(value, 99)) * 0.01;
                                            var millis =
                                                (duration.inMilliseconds *
                                                        newValue)
                                                    .toInt();
                                            _controller?.seekTo(
                                                Duration(milliseconds: millis));
                                            _controller?.play();
                                          }
                                        })),
                              ),
                            ),
                          ],
                        ),
                        _controlView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: FutureBuilder<List<SkillsVideoResponseModel>>(
                  future: _dataVideos,
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.data == null ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return buildShimmerEffect(
                            context,
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 4 -
                                          20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasData ||
                        snapshot.data != null ||
                        snapshot.connectionState == ConnectionState.done) {
                      _videosList = snapshot.data;
                      print(
                          "NNNNIIIIIIIIIIIIIIIIIIIGAAAAAAAAAAAAAAAAAAAAAAAAAA" +
                              _videosList![0].rating.toString());
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Topics",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                downloadProgress(context, tappedIndex),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              //  color: Colors.red,
                              child: ListView.builder(
                                  itemCount: _videosList!.length,
                                  itemBuilder: (context, index) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.0),
                                                child: SizedBox(
                                                  // height: 40,
                                                  width: 200,
                                                  //color: Colors.red,
                                                  child: Text(
                                                    "_videosList",

                                                    //   "HTML + CSS layout",
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xFF7C7C7C),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    ' 90 Reviews',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        RatingBar(
                                                          initialRating: 0.0,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: 24,
                                                          ratingWidget:
                                                              RatingWidget(
                                                            full: Icon(
                                                                Icons
                                                                    .star_rate_rounded,
                                                                color:
                                                                    darkBlueColor),
                                                            half: Icon(
                                                                Icons
                                                                    .star_half_rounded,
                                                                color:
                                                                    darkBlueColor),
                                                            empty: Icon(
                                                                Icons
                                                                    .star_border_rounded,
                                                                color:
                                                                    darkBlueColor),
                                                          ),
                                                          itemPadding:
                                                              EdgeInsets.zero,
                                                          onRatingUpdate:
                                                              (rating) {
                                                            print(
                                                                "||||||||||||||||||||||||||||||||||||||||||||");
                                                            print(rating);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: GestureDetector(
                                              //  onTap: () => Get.put(DemoHome()),
                                              onTap: () {
                                                _onTapVideo(index);
                                                setState(() {
                                                  tappedIndex = index;
                                                });
                                                print(
                                                    "===============================================================");
                                                print("Tapped Index is:" +
                                                    tappedIndex.toString());
                                                setState(() {
                                                  if (_playArea == false) {
                                                    _playArea = true;
                                                  }
                                                });
                                              },
                                              child:
                                                  //thumbNail(_futreImage)
                                                  Container(
                                                color: Colors.deepPurple[400],
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Image.network(
                                                      //   _videosList[index].,
                                                      "https://images.unsplash.com/photo-1546587348-d12660c30c50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bmF0dXJhbHxlbnwwfHwwfHw%3D&w=1000&q=80",
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    202,
                                                                    202,
                                                                    202)
                                                                .withOpacity(
                                                                    0.7),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: const Icon(
                                                          Icons.play_arrow,
                                                          color: Colors.black,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                            //margin: EdgeInsets.symmetric(horizontal: 20),
                                                            width: 35,
                                                            height: 35,
                                                            // alignment: Alignment
                                                            //     .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5),
                                                              ),
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  const Color(
                                                                      0xFF90A5F8),
                                                                  darkBlueColor,
                                                                ],
                                                                begin: Alignment
                                                                    .topRight,
                                                                end: Alignment
                                                                    .bottomLeft,
                                                              ),
                                                              //  color: Colors.red[300]
                                                            ),
                                                            child: Center(
                                                              child: dowloadButton(
                                                                  _videosList![
                                                                          tappedIndex]
                                                                      .videoUrl!,
                                                                  fileDownloaderProvider,
                                                                  index),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //   ThumbnailGenerate()
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                          )
                                        ],
                                      )),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),

              //
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(widget.skillId),
                        ));
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: darkBlueColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 194, 194, 194),
                            blurRadius: 14,
                            spreadRadius: 1,
                            offset: Offset(3, 3)),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Take a test",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            VideoPlayer(controller),
          ],
        ),
      );
    } else {
      return const AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )));
    }
  }

  var _onUpdateControllerTime;
  Duration? _position;
  Duration? _duration;
  var _progress = 0.0;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller insnull");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller cannot be intilaized");
      return;
    }
    _duration ??= _controller?.value.duration;
    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;

    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    final controller =
        VideoPlayerController.network(_videosList![index].videoUrl!);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  void _onTapVideo(int index) {
    _initializeVideo(index);
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0; //if is
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);

    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: darkBlueColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                if (noMute) {
                  _controller?.setVolume(0);
                } else {
                  _controller?.setVolume(1.0);
                }
                setState(() {});
              },
              icon: Icon(
                noMute ? Icons.volume_up_rounded : Icons.volume_off_outlined,
                // noMute ? color: Colors.white : color: Colors.red,
                size: 30,
              )),
          FlatButton(
              onPressed: () async {
                final index = _isPlayingIndex - 1;
                if (index >= 0 && _videosList!.length >= 0) {
                  _initializeVideo(index);
                } else {
                  Get.snackbar("Video", "No more vidoes to play",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(
                        Icons.face,
                        size: 25,
                        color: Colors.white,
                      ));
                }
              },
              child: const Icon(
                Icons.fast_rewind,
                size: 36,
                color: Colors.white,
              )),
          FlatButton(
              onPressed: () async {
                if (_isPlaying) {
                  setState(() {
                    _isPlaying = false;
                  });
                  _controller?.pause();
                } else {
                  setState(() {
                    _isPlaying = true;
                  });
                  _controller?.play();
                }
              },
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 36,
                color: Colors.white,
              )),
          FlatButton(
              onPressed: () async {
                final index = _isPlayingIndex + 1;
                if (index <= _videosList!.length - 1) {
                  _initializeVideo(index);
                } else {
                  Get.snackbar("Video List", "",
                      snackPosition: SnackPosition.BOTTOM,
                      messageText: const Text(
                        "No more vidoes available",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      backgroundColor: gradientSecond,
                      icon: const Icon(
                        Icons.face,
                        size: 25,
                        color: Colors.white,
                      ));
                }
              },
              child: const Icon(
                Icons.fast_forward,
                size: 36,
                color: Colors.white,
              )),
          Text(
            "$mins:$secs",
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
