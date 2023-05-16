import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PressureData {
  String? id;
  String? userId;
  DateTime? date;
  int? bpm;
  String? status;

  PressureData({
    required this.id,
    required this.userId,
    required this.date,
    required this.bpm,
    required this.status
  });

  PressureData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'] is Timestamp? (json['date'] as Timestamp).toDate(): DateTime.now();
    bpm = json['bpm'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['bpm'] = this.bpm;
    data['status'] = this.status;
    data['userId'] = this.userId;
    return data;
  }

  String toJsonString() {
    final str = json.encode(this.toJson());
    return str;
  }
}