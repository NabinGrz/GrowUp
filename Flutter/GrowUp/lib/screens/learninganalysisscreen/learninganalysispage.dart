import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/screens/learninganalysisscreen/progresswidgets.dart';
import 'package:growup/screens/learninganalysisscreen/tabswidget.dart';

class LearningAnalysisPage extends StatefulWidget {
  const LearningAnalysisPage({Key? key}) : super(key: key);

  @override
  _LearningAnalysisPageState createState() => _LearningAnalysisPageState();
}

class _LearningAnalysisPageState extends State<LearningAnalysisPage> {
  int _currentIndex = 0;
  bool isProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.34,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFADC2F3),
                  Color(0xff6077F7),
                ],
              ),
              color: Colors.purple[900],
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.022),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 80,
                      width: 150,
                      //  color: Colors.red,
                      child: Text(
                        "Learning Analysis",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Image.asset(
                      'images/learninganalysis.png',
                      width: 190,
                      //  color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width - (8 * edge),
                decoration: BoxDecoration(),
                child: CustomNavigationBar(
                  borderRadius: Radius.circular(50),
                  iconSize: 30.0,
                  selectedColor: Color(0xff040307),
                  strokeColor: Color(0x30040307),
                  unSelectedColor: Color(0xffacacac),
                  backgroundColor: Colors.white,
                  items: [
                    CustomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text("Progress"),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart),
                      title: Text("Performance"),
                    ),
                  ],
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                      if (_currentIndex == 0) {
                        isProgress = true;
                        print("Progress");
                      } else if (_currentIndex == 1) {
                        isProgress = false;
                        print("Performance");
                      }
                    });
                  },
                )),
          ),
          Column(
            children: [isProgress ? buildTextField() : Text("Progress")],
          )
        ],
      ),
    );
  }
}
