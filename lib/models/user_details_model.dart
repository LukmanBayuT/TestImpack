// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
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

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
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
