import 'package:growup/models/questions.dart';
import 'package:http/http.dart' as http;
import 'package:growup/services/apiservice.dart';

late var responseQuestions;
var dataQuestions;

var newsFeed2;
Future<List<QuestionModel>> getAllTestQuestion() async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/questionall",
  );
  responseQuestions = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseQuestions.statusCode == 200) {
    var data = await responseQuestions.body;
    dataQuestions = questionModelFromJson(data);

    return dataQuestions;
  } else {
    return [];
  }
  // return dataQuestions;
}
