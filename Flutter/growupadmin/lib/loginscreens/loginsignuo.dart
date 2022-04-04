import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growupadmin/apiservice/services.dart';
import 'package:growupadmin/colorpalettes/palette.dart';
import 'package:growupadmin/controller/myController.dart';
import 'package:growupadmin/screen/hometabscreen.dart/hometab.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginSignupScreen extends StatefulWidget {
  //static var tokenData;
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  var tokenData;
  bool isSignupScreen = true;
  bool isMale = true;
  bool isLogging = false;
  String? gender = "Male";
  //static var tokenData;
  bool isRememberMe = false;
  final _currencies = ['Student', 'Teacher'];
  var _currentItemSelected = 'Student';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var textValue;
  bool isValid = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullnameSignup = TextEditingController();
  TextEditingController emailSignup = TextEditingController();
  TextEditingController passwordSignup = TextEditingController();
  final genderController = Get.put(MyController());
  bool emailError = false;
  bool passwordError = false;
  bool fullnameSignupError = false;
  bool emailSignupError = false;
  bool passwordSignupError = false;
  final tokenDataStorage = const FlutterSecureStorage();
  final userIdDataStorage = const FlutterSecureStorage();
  static String? finaltokenData;
  Timer? _timer;
  checkValue() async {
    String value = await getData() ?? "";
    if (await getData() == null) {
      print("IS NULL");
    } else {
      print("HAS SOME DATA==> UI Class");
      print(value);
      await Future.delayed(
          //HomeTab()
          const Duration(seconds: 0),
          () => Get.to(const HomeTab()));
    }
    setState(() {
      finaltokenData = value;
    });
  }

  Future getData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedtokenData = sharedPreferences.getString("tokenData");
    print("THE TOKEN OF THIS USER IS");
    print(obtainedtokenData);
    return obtainedtokenData;
  }

  @override
  void initState() {
    super.initState();
    var token = getToken();
    checkValue();
  }

  @override
  Widget build(BuildContext context) {
    print("BUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIILLLLLLLLLLLLLLL");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xff7786ed),
                    darkBlueColor,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 130, left: 20),
                  // color: Color(0xFF2238c4).withOpacity(.85),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Hello There!!",
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.defaultDialog(
                                title: "Success!!",
                                middleText: "Login Successfull",
                                actions: [
                                  const Icon(
                                    Iconsax.chart_fail,
                                    size: 35,
                                    color: Color.fromARGB(255, 252, 25, 9),
                                  )
                                ],
                                buttonColor: Colors.white),
                            child: RichText(
                              text: TextSpan(
                                  text: "Welcome to",
                                  style: const TextStyle(
                                    fontSize: 21,
                                    letterSpacing: 2,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: " Grow",
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfffe6700),
                                      ),
                                    ),
                                    TextSpan(
                                      text: isSignupScreen ? "Up" : "",
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: greenColor,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 110,
                  width: 70,
                  decoration: BoxDecoration(
                      color: orangeColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                          bottomRight: Radius.circular(90))),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    height: 85,
                    width: 70,
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(90),
                            bottomRight: Radius.circular(90))),
                  ),
                )),
            Positioned(
                // alignment: Alignment.bottomRight,
                right: -12,
                bottom: -20,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(90),
                          bottomLeft: Radius.circular(90),
                          topRight: Radius.circular(90))),
                )),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              top: 200,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                height: 270,
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 9,
                          spreadRadius: 3),
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? activeColor
                                        : textColor1),
                              ),
                              // if (!isSignupScreen)
                              Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: orangeColor)
                            ],
                          ),
                        ],
                      ),
                      buildSigninSection()
                    ],
                  ),
                ),
              ),
            ),
            // Trick to add the submit button
            buildBottomHalfContainer(false),
          ],
        ),
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, "example@gmail.com", false, true,
              email, TextInputType.emailAddress),
          emailError
              ? builldErrorText("Please enter valid email address")
              : Container(
                  height: 15,
                ),
          buildTextField(Icons.lock_outline, "**********", true, false,
              password, TextInputType.name),
          passwordError
              ? builldErrorText("Please enter valid password")
              : Container(
                  height: 15,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: textColor1))
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget builldErrorText(String name) {
    return Container(
      height: 15,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  // Widget buildDropDown(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10),
  //       child: Container(
  //         width: 100,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: iconColor,
  //             boxShadow: const [
  //               BoxShadow(
  //                   color: Color(0xFFCCCCCC),
  //                   blurRadius: 14,
  //                   spreadRadius: -3,
  //                   offset: Offset(3, 7)),
  //             ]
  //             // color: Colors.amber,
  //             ),
  //         //  margin: EdgeInsets.all(20.0),
  //         child: Column(
  //           children: <Widget>[
  //             DropdownButton<String>(
  //               items: _currencies.map((String dropDownStringItem) {
  //                 return DropdownMenuItem<String>(
  //                   value: dropDownStringItem,
  //                   child: Text(dropDownStringItem),
  //                 );
  //               }).toList(),
  //               onChanged: (newValueSelected) {
  //                 _onDropDownItemSelected(newValueSelected!);
  //               },
  //               value: _currentItemSelected,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      // key: _formkey,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      top: 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 80,
          width: 80,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 15,
                      spreadRadius: 3)
              ]),
          child: !showShadow
              ? GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLogging = true;
                    });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomeTab()));
                    // Get.offAll(() => HomeTab());

                    // if (!isSignupScreen) {
                    print("IS LOGIN");
                    if (email.text.toString().isEmpty &&
                        password.text.toString().isEmpty) {
                      checkErrorLoginEmail();
                      checkErrorLoginPassword();
                      setState(() {
                        isLogging = false;
                      });
                    } else {
                      String selected = _currentItemSelected;
                      switch (selected) {
                        case "Student":
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(email.text.toString())) {
                            checkErrorLoginEmail();
                            setState(() {
                              isLogging = false;
                            });
                            print("not successful");
                          } else if (password.text.toString().isEmpty) {
                            checkErrorLoginPassword();
                            setState(() {
                              isLogging = false;
                            });
                          } else {
                            print("successful logino");
                            String emailData = email.text.trim();
                            String passwordData = password.text;
                            print(
                                "***************************************************************************");
                            print(tokenData);
                            if (tokenData != null) {
                              setState(() {
                                isLogging = false;
                              });
                            }
                            tokenData = await login(emailData, passwordData);
                            print(
                                "THE tokenData IS::::::::::::::::::::::::::::::::::::::::::::::::::");
                            print(tokenData);
                            //  if (tokenData == "Invalid Password") {
                            //     } else {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString("tokenData", tokenData);
                            await tokenDataStorage.write(
                                key: "tokenData", value: tokenData);
                            obtainedtokenData = tokenData;
                            setState(() {});
                            if (tokenData != "Invalid Password") {
                              Get.defaultDialog(
                                  title: "Success!!",
                                  middleText: "Login Successfull",
                                  actions: [
                                    const Icon(
                                      Iconsax.tick_circle,
                                      size: 35,
                                      color: Color.fromARGB(255, 23, 204, 92),
                                    )
                                  ],
                                  buttonColor: Colors.white);
                              Get.off(const HomeTab());
                              tokenPass();
                            } else {
                              setState(() {
                                isLogging = false;
                              });
                              Get.defaultDialog(
                                  title: "Oops!!",
                                  middleText: "Invalid Password/Email",
                                  actions: [
                                    const Icon(
                                      Iconsax.chart_fail,
                                      size: 35,
                                      color: Color.fromARGB(255, 252, 25, 9),
                                    )
                                  ],
                                  buttonColor: Colors.white);
                            }
                            print("tokenData IS: $tokenDataStorage");
                            //  }
                          }
                          break;
                        case "Teacher":
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(email.text.toString())) {
                            checkErrorLoginEmail();
                            setState(() {
                              isLogging = false;
                            });
                            print("not successful");
                          } else if (password.text.toString().isEmpty) {
                            checkErrorLoginPassword();
                            setState(() {
                              isLogging = false;
                            });
                          } else {
                            print("successful login");
                            String emailData = email.text.trim();
                            String passwordData = password.text;
                            var tokenData =
                                await login(emailData, passwordData);
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString("tokenData", tokenData);
                            await tokenDataStorage.write(
                                key: "tokenData", value: tokenData);
                            tokenData != "Invalid Password"
                                ? Get.off(const HomeTab())
                                : Get.defaultDialog(
                                    title: "Oops!!",
                                    middleText: "Invalid Password/Email",
                                    actions: [
                                      const Icon(
                                        Iconsax.chart_fail,
                                        size: 35,
                                        color: Color.fromARGB(255, 25, 202, 93),
                                      )
                                    ],
                                    buttonColor: Colors.white);
                            // Get.off(TeacherPage());
                            print("tokenData IS: $tokenDataStorage");
                          }
                          break;

                        default:
                      } // }
                    }

                    // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [darkBlueColor, const Color(0xff7786ed)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1))
                        ]),
                    child: isLogging
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                  ),
                )
              : const Center(),
        ),
      ),
    );
  }

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
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: textColor1),
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
    );
  }

  void checkErrorEmail() {
    setState(() {
      emailSignupError = true;
    });
  }

  void checkErrorfullname() {
    setState(() {
      fullnameSignupError = true;
    });
  }

  void checkErrorPassword() {
    setState(() {
      passwordSignupError = true;
    });
  }

  void checkErrorLoginEmail() {
    setState(() {
      emailError = true;
    });
  }

  void checkErrorLoginPassword() {
    setState(() {
      passwordError = true;
    });
  }

  tokenPass() {
    return tokenData;
  }

  getToken() {
    return tokenPass();
  }
}
