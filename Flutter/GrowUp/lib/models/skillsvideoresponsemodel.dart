// To parse this JSON data, do
//
//     final skillsVideoResponseModel = skillsVideoResponseModelFromJson(jsonString);

import 'dart:convert';

List<SkillsVideoResponseModel> skillsVideoResponseModelFromJson(String str) =>
    List<SkillsVideoResponseModel>.from(
        json.decode(str).map((x) => SkillsVideoResponseModel.fromJson(x)));

String skillsVideoResponseModelToJson(List<SkillsVideoResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkillsVideoResponseModel {
  SkillsVideoResponseModel({
    this.id,
    this.videoUrl,
    this.video,
    this.skillId,
    this.skill,
    this.rating,
  });

  int? id;
  String? videoUrl;
  dynamic video;
  int? skillId;
  dynamic? skill;
  double? rating;

  factory SkillsVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      SkillsVideoResponseModel(
        id: json["id"],
        videoUrl: json["videoUrl"],
        video: json["video"],
        skillId: json["skillId"],
        skill: json["skill"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "videoUrl": videoUrl,
        "video": video,
        "skillId": skillId,
        "skill": skill,
        "rating": rating,
      };
}
