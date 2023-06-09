import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_pulse_health/data/workout_data.dart';

class UserData {
  String? uuid;
  String? name;
  String? photo;
  String? mail;
  List<WorkoutData>? workouts;

  UserData({
    required this.uuid,
    required this.name,
    required this.photo,
    required this.mail,
    required this.workouts,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    uuid = json['uid'];
    name = json['name'];
    photo = json['photo'];
    mail = json['mail'];
    if (json['workouts'] != null) {
      List<WorkoutData> workouts = [];
      json['workouts'].forEach((v) {
        workouts.add(new WorkoutData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['mail'] = this.mail;
    if (this.workouts != null) {
      data['workouts'] = this.workouts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static fromFirebase(User? user) {
    return user != null
        ? UserData(
      uuid: user.uid,
      name: user.displayName ?? "",
      photo: user.photoURL ?? "",
      mail: user.email ?? "",
      workouts: [],
    )
        : [];
  }
  //
  // static toJsonString(){
  //   return UserData(name: "",
  //   photo: "",
  //   mail: "",
  //   workouts: []);
  // }
}