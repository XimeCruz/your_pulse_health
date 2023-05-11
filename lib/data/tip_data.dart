import 'dart:convert';

import 'package:your_pulse_health/data/exercise_data.dart';

class TipData {
  String? id;
  String? title;
  String? description;
  String? textTip;
  String? exercises;
  String? minutes;
  int? currentProgress;
  int? progress;
  String? image;
  List<ExerciseData>? exerciseDataList;

  TipData({
    required this.id,
    required this.title,
    required this.description,
    required this.textTip,
    required this.exercises,
    required this.minutes,
    required this.currentProgress,
    required this.progress,
    required this.image,
    required this.exerciseDataList,

  });

  TipData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    textTip = json['textTip'];
    description = json['description'];
    exercises = json['exercises'];
    minutes = json['minutes'];
    currentProgress = json['currentProgress'];
    progress = json['progress'];
    image = json['image'];
    if (json['exerciseDataList'] != null) {
      List<ExerciseData> exercises = [];
      json['exerciseDataList'].forEach((v) {
        exercises.add(ExerciseData.fromJson(v));
      });
      exerciseDataList = exercises;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['textTip'] = this.textTip;
    data['exercises'] = this.exercises;
    data['minutes'] = this.minutes;
    data['currentProgress'] = this.currentProgress;
    data['progress'] = this.progress;
    data['image'] = this.image;
    if (this.exerciseDataList != null) {
      data['exerciseDataList'] =
          this.exerciseDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJsonString() {
    final str = json.encode(this.toJson());
    return str;
  }
}