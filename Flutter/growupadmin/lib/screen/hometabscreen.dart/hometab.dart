import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growupadmin/colorpalettes/palette.dart';
import 'package:growupadmin/screen/buildQuizScreen.dart/buildQuizScreen.dart';
import 'package:growupadmin/screen/buildtestpaper.dart/buildExamScreen.dart';
import 'package:growupadmin/screen/hometabscreen.dart/adminhomepage.dart';
import 'package:growupadmin/screen/hometabscreen.dart/skillsaddscree.dart';
import 'package:growupadmin/screen/videoPostScreen.dart/videoPost.dart';
import 'package:iconsax/iconsax.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _selectedIndex = 0;
  bool isDrawerOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  bool tabIsSelected = false;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  drawer: DrawerScreen(),
        appBar: AppBar(
          backgroundColor: darkBlueColor,
          title: const Text("GrowUp Admin"),
          actions: [
            SizedBox(
                height: 25,
                width: 50,
                child: IconButton(
                    onPressed: () {
                      // var d = getSkillVideos(1);
                      // var d = bookTutor(
                      //     "zoomId", "zoompassword", "2022-02-02", "T05:50:06");
                      // print("NEWS FEED DATA");

                      // print(d);
                      Get.to(() => const BuildQuizScreen());
                    },
                    icon: const Icon(
                      Iconsax.notification,
                    ))),
          ],
          centerTitle: true,
        ),
        body: Container(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: <Widget>[
              const HomePageScreen(),
              SkillsAddScreen(),
              const BuildExamScreen(),
              const BuildQuizScreen(),
              SkillVideoPost()
              // PostScreen(),
              //Profile()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: darkBlueColor,
          selectedIndex: _selectedIndex,
          // showElevation: false,

          onItemSelected: (index) => setState(() {
            tabIsSelected = true;
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
                icon: const Icon(Iconsax.home_1),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 18),
                ),
                activeColor: Colors.white,
                inactiveColor: Colors.white),
            BottomNavyBarItem(
                icon: const Icon(Iconsax.activity),
                title: const Text(
                  'Course',
                  style: TextStyle(fontSize: 18),
                ),
                activeColor: Colors.white,
                inactiveColor: Colors.white),
            BottomNavyBarItem(
                icon: const Icon(Iconsax.add_square),
                title: const Text(
                  'Exam',
                  style: TextStyle(fontSize: 18),
                ),
                inactiveColor: Colors.white,
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: const Icon(Iconsax.book),
                title: const Text(
                  'Quiz',
                  style: TextStyle(fontSize: 18),
                ),
                inactiveColor: Colors.white,
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: const Icon(Iconsax.note),
                title: const Text(
                  'Videos',
                  style: TextStyle(fontSize: 18),
                ),
                inactiveColor: Colors.white,
                activeColor: Colors.white),
          ],
        ));
  }

  _buildPage({IconData? icon, String? title, Color? color}) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 200.0, color: Colors.white),
            Text(title!,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
