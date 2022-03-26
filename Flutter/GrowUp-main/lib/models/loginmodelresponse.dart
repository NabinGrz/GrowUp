// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.message,
    this.isSuccess,
    this.errors,
    this.expireDate,
  });

  String? message;
  bool? isSuccess;
  dynamic? errors;
  DateTime? expireDate;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        errors: json["errors"],
        expireDate: DateTime.parse(json["expireDate"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "errors": errors,
        "expireDate": expireDate!.toIso8601String(),
      };
}
