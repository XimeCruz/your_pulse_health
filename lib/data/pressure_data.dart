import 'dart:convert';

class PressureData {
  String? id;
  String? date;
  int? bpm;

  PressureData({
    required this.id,
    required this.date,
    required this.bpm,
  });

  PressureData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    bpm = json['bpm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['bpm'] = this.bpm;
    return data;
  }

  String toJsonString() {
    final str = json.encode(this.toJson());
    return str;
  }
}