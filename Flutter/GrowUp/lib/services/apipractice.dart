import 'package:flutter/services.dart';
import 'package:growup/models/practicemodel.dart';

List<Practice>? questions;
Future<List<Practice>> getPracticeQuestions() async {
  final String response = await rootBundle.loadString('json/practice.json');
  var _dataQuestions = await Future.delayed(
      const Duration(seconds: 1), () => practiceFromJson(response));
  var the = _dataQuestions;
  questions = _dataQuestions.toList();

  // else {
  //   print("fetch error");
  // }
  //print("Question:" + questions![1].skill);
  return questions!;
}
