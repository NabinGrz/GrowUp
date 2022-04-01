import 'dart:convert';

import 'package:growup/services/apiservice.dart';
import 'package:http/http.dart' as http;

var postingResponse;
Future<bool> postQuestion(String skillId, String question) async {
  var responsePostingQuestion =
      await http.post(Uri.https(baseUrlPost, 'api/v1/question'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>{"SkillId": skillId, "Text": question}));
  if (responsePostingQuestion.statusCode == 200) {
    var response = responsePostingQuestion.body;
    var data = jsonDecode(response);
    postingResponse = data;

    return true;
  } else {
    return false;
  }
}

var postingOptions;
Future postOptions(int skillId, String question, bool isCorrect) async {
  var responsePostingOptions = await http.post(
      Uri.https(baseUrlPost, 'api/v1/option'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $obtainedtokenData',
      },
      body: jsonEncode(
          // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
          <String, dynamic>{
            "text": question,
            "questionId": skillId,
            "isCorrectOption": isCorrect
          }));
  if (responsePostingOptions.statusCode == 200) {
    var response = responsePostingOptions.body;
    var data = jsonDecode(response);
    postingOptions = data;

    return true;
  } else {
    return false;
  }
}
