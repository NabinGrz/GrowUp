import 'dart:convert';

import 'package:growupadmin/apiservice/services.dart';
import 'package:growupadmin/models/exammodel.dart';
import 'package:growupadmin/models/testmodel.dart';
import 'package:http/http.dart' as http;

var postingResponse;
Future<bool> postExam(String skillId, String name, String difficulty,
    String tutorname, String totalquestions) async {
  var responsePostingExam =
      await http.post(Uri.https(baseUrlPost, 'api/v1/save/exam'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $adminToken',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>
              // { "SkillId": skillId, "Text": question}

              {
                "SkillId": skillId,
                "Name": name,
                "Difficulty": difficulty,
                "TutorName": tutorname,
                "TotalQuestions": totalquestions
              }));
  if (responsePostingExam.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var postingTest;
Future<bool> postTest(String question, String examID) async {
  var responsePostingTest =
      await http.post(Uri.https(baseUrlPost, 'api/v1/save/test'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $adminToken',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>{"Question": question, "ExamID": examID}));
  if (responsePostingTest.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var postingOptions;
Future<bool> postTestOptions(String text, String testID, bool isCorrect) async {
  var responsePostingTest = await http.post(
      Uri.https(baseUrlPost, 'api/v1/save/testoption'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $adminToken',
      },
      body: jsonEncode(
          // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
          <String, dynamic>{
            "text": text,
            "IsCorrectOption": isCorrect,
            "testID": testID
          }));
  if (responsePostingTest.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var responseExam;
List<ExamModel>? examData;
Future<List<ExamModel>> getAllExamList() async {
  var myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/getallexam",
  );
  responseExam = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $adminToken',
  });
  if (responseExam.statusCode == 200) {
    var data = await responseExam.body;
    examData = examModelFromJson(data);
    return examData!;
  } else {
    return [];
  }
}

var responseTest;
List<TestModel>? testData;
Future<List<TestModel>> getAllTestList(int id) async {
  var myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/testquestion?id=$id",
  );
  responseTest = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $adminToken',
  });
  if (responseTest.statusCode == 200) {
    var data = await responseTest.body;
    testData = testModelFromJson(data);
    return testData!;
  } else {
    return [];
  }
}

var responseExamAllTest;
List<TestModel>? examalltest;
Future<List<TestModel>> getAllTestofExam(int id) async {
  var myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/getalltestofexam?examID=$id",
  );
  responseExamAllTest = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $adminToken',
  });
  if (responseExamAllTest.statusCode == 200) {
    var data = await responseExamAllTest.body;
    examalltest = testModelFromJson(data);
    return examalltest!;
  } else {
    return [];
  }
}
