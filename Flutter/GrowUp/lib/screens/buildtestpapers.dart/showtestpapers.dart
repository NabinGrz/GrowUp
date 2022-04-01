import 'package:flutter/material.dart';
import 'package:growup/models/questions.dart';
import 'package:growup/services/apitest.dart';

import '../../colorpalettes/palette.dart';

class TestPapersList extends StatefulWidget {
  @override
  State<TestPapersList> createState() => _TestPapersListState();
}

class _TestPapersListState extends State<TestPapersList> {
  var skillID;

  @override
  var tests;
  getData() async {
    tests = await getAllTestQuestion();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTestQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: FutureBuilder<List<QuestionModel>>(
            future: getAllTestQuestion(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData ||
                  snapshot.data != null ||
                  snapshot.connectionState == ConnectionState.done) {
                List<QuestionModel> listQuestions = snapshot.data;
                return ListView.builder(
                    itemCount: listQuestions.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width - 50,
                              color: Colors.red,
                              child: buildTextWidget(
                                  listQuestions[index].id.toString())),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    });
              }
              return Container(
                color: Colors.yellow,
              );
            }),
      ),
    );
  }
}

Widget buildTextWidget(String name) {
  return Text(
    name,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}
