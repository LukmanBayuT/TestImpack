// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

List<UserList> userListFromJson(String str) =>
    List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String userListToJson(List<UserList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
  UserList({
    this.id,
    this.activityType,
    this.institution,
    this.when,
    this.objective,
    this.remarks,
    this.complete,
  });

  final String? id;
  final String? activityType;
  final String? institution;
  final DateTime? when;
  final String? objective;
  final String? remarks;
  final String? complete;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        activityType: json["activityType"],
        institution: json["institution"],
        when: DateTime.parse(json["when"]),
        objective: json["objective"],
        remarks: json["remarks"],
        complete: json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activityType": activityType,
        "institution": institution,
        "when": when!.toIso8601String(),
        "objective": objective,
        "remarks": remarks,
        "complete": complete,
      };
}
