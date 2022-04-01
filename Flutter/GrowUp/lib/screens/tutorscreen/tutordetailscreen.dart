import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/services/apiserviceteacher.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorDetailScreen extends StatefulWidget {
  List<dynamic>? usersDetail;
  int? index;
  // String? check;
  TutorDetailScreen(
      {Key? key, @required this.usersDetail, @required this.index})
      : super(key: key);

  @override
  State<TutorDetailScreen> createState() =>
      _TutorDetailScreenState(usersDetail: usersDetail, index: index);
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  List<dynamic>? usersDetail;
  int? index;
  var userId;
  // String? check;
  _TutorDetailScreenState({this.usersDetail, this.index});
  DateTime selectedDate = DateTime.now();
  var finalDate;
  var isBooked;
  String? _selectedTime;
  TextEditingController zoomIdController = TextEditingController();
  TextEditingController zoomPasswordController = TextEditingController();

  getData() async {
    userId = await getUserAppId();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                primaryColor: Colors.black54,
                splashColor: Colors.black,
                brightness: Brightness.dark),
            child: child ?? const Text(""),
          );
        },
        initialTime: TimeOfDay.now());
    if (result != null) {
      int hour = result.hour;
      int minute = result.minute;
      String finalMinute = minute.toString();

      print("===================================================");
      print(hour);
      print(minute);
      if (finalMinute.length == 2) {
        print("fdzsssssssssdfsdfsd");
        setState(() {
          finalMinute = finalMinute;
        });
      } else {
        print("+++++++++++++++++++++++++");
        setState(() {
          finalMinute = "0" + finalMinute;
        });
      }
      print("final" + finalMinute);

      setState(() {
        _selectedTime = hour.toString() + ":" + finalMinute;

        print(_selectedTime);
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                primaryColor: Colors.black54,
                splashColor: Colors.black,
                brightness: Brightness.dark),
            child: child ?? const Text(""),
          );
        });
    if (picked != null && picked != selectedDate) {
      String d = DateFormat("yyyy-MM-dd").format(picked);
      setState(() {
        selectedDate = DateTime.parse(d);
      });
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
      print(selectedDate);
    }
    finalDate = DateFormat("yyyy-MM-dd").format(selectedDate);
    return finalDate;
  }

  // Map finalDetail = usersDetail.toJson();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.red,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3 + 20,
              width: MediaQuery.of(context).size.width,
              color: darkBlueColor,
            ),
            Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height / 3 - 90,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 21,
                          //color: Colors.yellow,
                          child: const Text(
                            'About Me',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Text(
                          'Hello! My name is Elliot Smith. As a born and raised New Yorker, I take food quite seriously. I have worked for a variety of restaurants and franchises to create logos, brochures, websites, menus, product labels and countless other deliverables.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0xFFD6D6D6),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height / 21,
                          //color: Colors.yellow,
                          child: const Text(
                            'Email Address',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        //  usersDetail[0].
                        Text(
                          "${usersDetail?[index!].userName}",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0xFFD6D6D6),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height / 21,
                          //color: Colors.yellow,
                          child: const Text(
                            'Education',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Text(
                          "BSc.CSIT",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        _buildDateTime(context),
                        const Divider(
                          thickness: 1,
                          color: Color(0xFFD6D6D6),
                        ),

                        // Text(
                        //   'Service List',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 22,
                        //   ),
                        // ),

                        const SizedBox(
                          height: 5,
                        ),
                        //   ServiceTile(usersDetail: usersDetail, index: index),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MaterialButton(
                            minWidth: 200,
                            onPressed: () async {
                              var name = usersDetail?[index!].fullName;
                              //   isBooked;
                              print(
                                  "===================BOOKING============================");
                              //  print(isBooked);
                              Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: "Booking",
                                  middleText:
                                      "You will have your private class in zoom video calling app",
                                  content: Column(
                                    children: [
                                      TextFormField(
                                        controller: zoomIdController,
                                        //obscureText: isPassword,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          // labelText: "NabinGurung",
                                          errorText: null,
                                          // prefixIcon: Icon(
                                          //  // icon,
                                          //   color: iconColor,
                                          // ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: textColor1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(35.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: textColor1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(35.0)),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          hintText: "Enter Meeting ID",
                                          hintStyle: TextStyle(
                                              fontSize: 14, color: textColor1),
                                        ),
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     print("====================================");
                                        //     print("object");
                                        //     setState(() {
                                        //       isValid = !isValid;
                                        //     });
                                        //     return 'Please Enter Name';
                                        //   }
                                        //   return null;
                                        // },
                                        // onSaved: (String? value) {
                                        //   textValue = value;
                                        // },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: zoomPasswordController,
                                        //obscureText: isPassword,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          // labelText: "NabinGurung",
                                          errorText: null,
                                          // prefixIcon: Icon(
                                          //  // icon,
                                          //   color: iconColor,
                                          // ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: textColor1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(35.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: textColor1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(35.0)),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          hintText: "Enter Meeting Passcode",
                                          hintStyle: TextStyle(
                                              fontSize: 14, color: textColor1),
                                        ),
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     print("====================================");
                                        //     print("object");
                                        //     setState(() {
                                        //       isValid = !isValid;
                                        //     });
                                        //     return 'Please Enter Name';
                                        //   }
                                        //   return null;
                                        // },
                                        // onSaved: (String? value) {
                                        //   textValue = value;
                                        // },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    RaisedButton(
                                        color: Colors.red,
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          print("MEETING HAS NOT ENDED");
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        }),
                                    RaisedButton(
                                      color: Colors.red,
                                      child:
                                          // isBooked
                                          const Text(
                                        "Book",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // : CircularProgressIndicator(),
                                      onPressed: () async {
                                        // Get.to(() => const KhaltiPaymentApp());
                                        var name =
                                            usersDetail?[index!].fullName;
                                        bool booked = await bookTutor(
                                            usersDetail?[index!].id,
                                            userId.toString(),
                                            zoomIdController.text,
                                            zoomPasswordController.text,
                                            finalDate.toString(),
                                            _selectedTime!);
                                        setState(() {
                                          isBooked = booked;
                                        });
                                        isBooked
                                            ? Get.snackbar(
                                                "Booked",
                                                "Your class has been booked with Mr. $name",
                                                icon: const Icon(Icons.person,
                                                    color: Colors.white),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                              )
                                            : Get.snackbar(
                                                "Booking Unsuccessfull",
                                                "SORRY!!",
                                                icon: const Icon(Icons.person,
                                                    color: Colors.white),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                              );

                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                    )
                                  ],
                                  buttonColor: Colors.white);

                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => KhaltiPaymentApp()));
                            },
                            color: const Color(0xffFF8573),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Book Now',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        // ServiceTile(usersDetail: usersDetail, index: index),
                        // ServiceTile(usersDetail: usersDetail, index: index),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3 - 20,
                  height: MediaQuery.of(context).size.height / 6 + 3,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFA8C8C),
                        Color(0xFFEC5B5B),
                        // HexColor(#738AE6),
                        // HexColor(#5C5EDD),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "images/person.png",
                    fit: BoxFit.contain,
                    // scale: 1.7,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.21,
              right: 20,
              child: Container(
                // color: Colors.red,
                // height: 100,
                // width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${usersDetail?[index!].fullName}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              const num = '+9779846458568';
                              await FlutterPhoneDirectCaller.callNumber(num);
                            },
                            icon: const Icon(
                              Iconsax.call,
                              color: Colors.green,
                              size: 20,
                            )),
                        IconButton(
                            onPressed: () => launchEmail(
                                toEmail: "${usersDetail?[index!].userName}",
                                subject: "To Pass",
                                message: "THE SUBJECT IS"),
                            icon: const Icon(
                              Iconsax.message,
                              color: Colors.green,
                              size: 20,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RatingBar(
                          initialRating: 0.0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star_rate_rounded,
                                color: darkBlueColor),
                            half: Icon(Icons.star_half_rounded,
                                color: darkBlueColor),
                            empty: Icon(Icons.star_border_rounded,
                                color: darkBlueColor),
                          ),
                          itemPadding: EdgeInsets.zero,
                          onRatingUpdate: (rating) async {
                            print(
                                "||||||||||||||||||||||||||||||||||||||||||||");
                            print(rating);
                            var ratingResponse = await postTeacherRating(
                                usersDetail![index!].id.toString(), rating);
                            await ratingResponse
                                ? Fluttertoast.showToast(
                                    msg:
                                        "Rating of $rating has been given for this tutor",
                                  )
                                : Fluttertoast.showToast(
                                    msg: "Rating unsuccessfull",
                                  );
                            print(
                                "11111111111111110000000000000000011111111111111111111111111111");
                            print("Teacher id" +
                                usersDetail![index!].id.toString());
                            print(ratingResponse);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Give Rating",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            // Positioned(
            //   right: 10,
            //   top: MediaQuery.of(context).size.height / 3 - 55,
            //   child: MaterialButton(
            //     onPressed: () {},
            //     padding: EdgeInsets.all(10),
            //     shape: CircleBorder(),
            //     color: Colors.white,
            //     child: Icon(OMIcons.favoriteBorder),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 1,
          color: Color(0xFFD6D6D6),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 21,
          //color: Colors.yellow,
          child: const Text(
            'Schedule your Date',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: 40.0,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: darkBlueColor,
            //border: Border.all(color: Colors.white)
          ),
          child: InkWell(
            onTap: () {
              _selectDate(context);
              print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
              // print(_selectDate(context).toString());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: darkBlueColor,
                      //border: Border.all(color: Colors.white)
                    ),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(selectedDate),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )),
                Container(
                    child: const Icon(Iconsax.calendar_add,
                        color: Colors.white, size: 20))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 21,
          //color: Colors.yellow,
          child: const Text(
            'Schedule your Time',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: 40.0,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: darkBlueColor,
            //border: Border.all(color: Colors.white)
          ),
          child: InkWell(
            onTap: () {
              //  await _selectTime(context);
              _selectTime(context);
              //print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
              // print(_selectTime(context).toString());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: darkBlueColor,
                      //border: Border.all(color: Colors.white)
                    ),
                    child: Text(
                      _selectedTime != null
                          ? _selectedTime!
                          : TimeOfDay.now().format(context),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )),
                Container(
                    child: const Icon(
                  Iconsax.watch,
                  color: Colors.white,
                  size: 20,
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future launchEmail({required String toEmail, subject, message}) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
    print("ISSSSSSSSSSSS   EMAILLLLLLLLLLL");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
