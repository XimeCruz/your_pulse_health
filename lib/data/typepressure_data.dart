import 'dart:convert';

class TypePressureData {
  String? name;
  String? text;

  TypePressureData({
    required this.name,
    required this.text
  });

  TypePressureData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['text'] = this.text;
    return data;
  }

  String toJsonString() {
    final str = json.encode(this.toJson());
    return str;
  }
}