import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/bookedclassesmodel.dart';
import 'package:growup/screens/tutorscreen/searchtutor.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/services/apiserviceteacher.dart';
import 'package:growup/widgets/shimmer.dart';
import 'package:iconsax/iconsax.dart';

class BookedClasses extends StatefulWidget {
  @override
  State<BookedClasses> createState() => _BookedClassesState();
}

class _BookedClassesState extends State<BookedClasses> {
  String? userId;
  getData() async {
    userId = await getUserAppId();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print("BUIIIIIIIIIIIIIIIIIIIIIIIIIIIIILLLD");
    //void
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
            icon: const Icon(Icons.search_sharp),
          )
        ],
        centerTitle: true,
        title: const Text(
          'Your Classes',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      StylistCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StylistCard extends StatefulWidget {
  @override
  State<StylistCard> createState() => _StylistCardState();
}

class _StylistCardState extends State<StylistCard> {
  var bookedClasses;

  String? userId;
  getData() async {
    userId = await getUserAppId();
    bookedClasses = getBookedClasses(userId!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<BookedClassesModel>>(
        future: bookedClasses,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            print("waiiiiiiiiitttttttttttttttttttttttttttttttttttttty");
            return buildShimmerEffect(
              context,
              Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            print("sooooooooorrrrrrrrrrrrrrrrrrrrrrrrrry");
            return Container(
              //color: Colors.red,
              child: const Center(
                  child: Text(
                "No classes!!",
                style: TextStyle(fontSize: 25, color: Colors.grey),
              )),
            );
          } else if (snapshot.hasData ||
              snapshot.data != null ||
              snapshot.connectionState == ConnectionState.done) {
            var classes = snapshot.data;
            return SizedBox(
              //height: 500,
              width: MediaQuery.of(context).size.width,
              // color: Colors.yellow,
              child: ListView.builder(
                  itemCount: classes!.length,
                  itemBuilder: (context, index) {
                    String bookingDate = classes[index]
                        .bookingDateTime
                        .toString()
                        .substring(0, 10);
                    String bookingTime = classes[index]
                        .bookingDateTime
                        .toString()
                        .substring(11, 16);
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        classes.removeAt(index);
                        Get.snackbar(
                          "Dismissed",
                          "Class has been dismissed",
                          icon: const Icon(Icons.person, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      background: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5.5,
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFF8A8A8A),
                                  blurRadius: 14,
                                  spreadRadius: 1,
                                  offset: Offset(3, 3)),
                            ],
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff738AE6),
                                // darkBlueColor
                                Color(0xff5C5EDD),
                                // HexColor(#738AE6),
                                // HexColor(#5C5EDD),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            //  color: Colors.red[300]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                    //  top: 5,
                                    right: 10,
                                    //alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: "Alert Dialog",
                                              middleText:
                                                  "Are u sure u have complete the class?",
                                              actions: [
                                                RaisedButton(
                                                    color: Colors.red,
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          "MEETING HAS NOT ENDED");
                                                    }),
                                                RaisedButton(
                                                    color: Colors.red,
                                                    child: const Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          "MEETING HAS ENDED");
                                                    })
                                              ],
                                              buttonColor: Colors.white);
                                        },
                                        icon: const Icon(
                                          Iconsax.profile_delete,
                                          color: Colors.red,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FutureBuilder<dynamic>(
                                        future: getUserDetails(
                                            classes[index].studentId!),
                                        builder: (context, snapshot) {
                                          String bookingDate = classes[index]
                                              .bookingDateTime
                                              .toString();
                                          if (snapshot.hasData) {
                                            return Text(
                                              "Student Name: " +
                                                  snapshot.data.fullName
                                                      .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Text("NULL");
                                          }
                                          return const SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ));
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Your Meeting ID of zoom: ${classes[index].zoomId}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Your Passcode of zoom: ${classes[index].zoomPassword}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Booking Date: $bookingDate",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "BookingTime: $bookingTime",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            print("sooooooooorrrrrrrrrrrrrrrrrrrrrrrrrry");
            return Container(
              color: Colors.red,
            );
          }
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
}
