import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/downloads/download_provider.dart';
import 'package:growup/screens/paymentscreen/khalti_payment.dart';
import 'package:growup/screens/tutorscreen/tutorlist.dart';
import 'package:growup/screens/drawerscreen/drawer_screen.dart';
import 'package:growup/screens/homescreen/homepage_screen.dart';
import 'package:growup/screens/loginscreens/loginsignuo.dart';
import 'package:growup/screens/newsfeedscreen/newsfeed.dart';
import 'package:growup/screens/splash_screen/splashscreen.dart';
import 'package:growup/utility/easyloading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FileDownloaderProvider(),
          child: SplashScreen(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: SplashScreen())));
  configLoading();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: darkBlueColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Scaffold(
        body: Stack(
          children: [
            //DrawerScreen(),
            //   Get.to(() => const KhaltiPaymentApp());
            KhaltiPaymentApp(),
          ],
        ),
      ),
    );
  }
}
