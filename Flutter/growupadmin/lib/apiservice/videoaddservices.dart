import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:growupadmin/apiservice/services.dart';
import 'package:http/http.dart' as http;

var _postSkillsVideoData;
var responsepostSkillsVideo;
var reponseMessage;
bool postSuccess = false;
Future<bool> postSkillsVideo(String id, String videotitle, File file) async {
  var request =
      http.MultipartRequest("POST", Uri.parse("$baseUrlGet/api/v1/video"));
  request.headers.addAll({
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $adminToken',
  });
  //SkillCategoryId
  request.fields['VideoUrl'] = videotitle;
  request.files.add(await http.MultipartFile.fromPath('Video', file.path));
  request.fields['SkillId'] = id;
  await request.send().then((response) {
    http.Response.fromStream(response).then((onValue) {
      if (response.statusCode == 200) {
        print(
            "==============================VIDEO================================");
        Fluttertoast.showToast(
          msg: "Videos of the course has been added successfully",
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
        return false;
      }
    });
  });

  return false;
}
