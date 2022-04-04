import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:growupadmin/models/categorymodels.dart';
import 'package:growupadmin/models/loginmodelresponse.dart';
import 'package:growupadmin/models/registerresponsemodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var obtainedtokenData;
getToken() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  obtainedtokenData = sharedPreferences.getString("tokenData");

  return obtainedtokenData;
}

var adminToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbWFpbCI6Im5pYmFuZ3JnMjJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI3NmE0OTY5Yi05YjA0LTRlYzYtOTViMS0wNmYxOTBiNDBlNGUiLCJleHAiOjE2NTE2Mzc5MzIsImlzcyI6Imh0dHA6Ly9tYWhhcmphbnNhY2hpbi5jb20ubnAiLCJhdWQiOiJodHRwOi8vbWFoYXJqYW5zYWNoaW4uY29tLm5wIn0.AlFyNuv_WPqU54xWg3mcNcb7BuO822E8io_hR2yD5So";
const baseUrlGet =
    "https://4c7b-2400-1a00-b020-5e1b-21a7-3c75-6b30-7545.ngrok.io";
const baseUrlPost = "4c7b-2400-1a00-b020-5e1b-21a7-3c75-6b30-7545.ngrok.io";
var _loginResponseData;
var responseLoginTokken;
Future login(String email, String password) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseLogin =
      await http.post(Uri.http(baseUrlPost, 'api/v1/account/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, dynamic>{
              "Email": email,
              "Password": password,
            },
          ));

  var loginResponse = responseLogin.body;
  print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(loginResponse);
  if (loginResponse == "Some properties are not valid") {
    return "Invalid Password";
  } else {
    var data =
        loginResponseModelFromJson(loginResponse); //response after posting
    _loginResponseData =
        data; //response data, i.e. {"message":"User Created Successfully!","isSuccess":true,"errors":null,"expireDate":null}"
    print("======================================================");
    print(responseLogin.statusCode);
    responseLoginTokken = _loginResponseData.message;
    if (responseLogin.statusCode == 200) {
      return responseLoginTokken;
    } else {}
    print("API CLASS TOKE");
    print(responseLoginTokken);
    return responseLoginTokken;
  }
}

var _registerResponseData;
var _registerResponseMessage;

Future register(String email, String password, String confirmpassword,
    String fullName, String gender, String address, String role) async {
  var responseRegisterString =
      await http.post(Uri.http(baseUrlPost, 'api/v1/account/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, dynamic>{
              "Email": email,
              "Password": password,
              "ConfirmPassword": confirmpassword,
              "FullName": fullName,
              "Gender": gender,
              "Address": address,
              "Role": role
            },
          ));
//User did not create
  var registerResponse = responseRegisterString.body;
  // if (registerResponse == "Some properties are not valid") {
  //   return "Invalid Password";
  // }
  var data =
      registerResponseModelFromJson(registerResponse); //response after posting
  _registerResponseData =
      data; //response data, i.e. {"message":"User Created Successfully!","isSuccess":true,"errors":null,"expireDate":null}"
  print("======================================================");
  print(responseRegisterString.statusCode);
  _registerResponseMessage = _registerResponseData.message;
  if (_registerResponseMessage == "User did not create") {
    return "Account registered already";
  }
  if (responseRegisterString.statusCode == 200) {
    return _registerResponseMessage;
  } else {}
  return _registerResponseMessage;
}

var postingResponse;
Future<bool> postSkillCategory(String name) async {
  var responsePostingQuestion =
      await http.post(Uri.https(baseUrlPost, 'api/v1/category'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $adminToken',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>{"Name": name}));
  if (responsePostingQuestion.statusCode == 200) {
    var response = responsePostingQuestion.body;
    var data = jsonDecode(response);
    postingResponse = data;

    return true;
  } else {
    return false;
  }
}

var _postSkillsData;
var responsepostSkills;
var reponseMessage;
bool postSuccess = false;
Future postSkills(String id, String title, File file) async {
  var request =
      http.MultipartRequest("POST", Uri.parse("$baseUrlGet/api/v1/Skill"));
  request.headers.addAll({
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $adminToken',
  });
  //SkillCategoryId
  request.fields['Title'] = title;
  request.files.add(await http.MultipartFile.fromPath('ImageFile', file.path));
  request.fields['SkillCategoryId'] = id;
  request.send().then((response) {
    http.Response.fromStream(response).then((onValue) {
      // get your response here...
      if (response.statusCode == 200) {
        reponseMessage = response.reasonPhrase;
        print("===================SUCCESS==================");
        Fluttertoast.showToast(
          msg: "Posted Successfully",
        );
        return true;
      } else {
        print("======================UNSUCCESSFULL==========================");
        return false;
      }
    });
  });
//  return reponseMessage;
}

late var responseCat;
late List<CategoryModel> dataCategory;
var newsFeed2;
Future<List<CategoryModel>> getAllCat({String? query}) async {
  //var token = await _Login;
  var url = Uri.parse("$baseUrlGet/api/v1/allcategory");

  var responseCat = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $adminToken',
  });
  if (responseCat.statusCode == 200) {
    var data = responseCat.body;
    dataCategory = categoryModelFromJson(data);
    return dataCategory;
  } else {
    print("fetch error");
  }

  return newsFeed2!;
}
