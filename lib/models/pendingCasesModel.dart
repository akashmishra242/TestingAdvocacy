// To parse this JSON data, do
//
//     final pendingCasesmodel = pendingCasesmodelFromJson(jsonString);

import 'dart:convert';

PendingCasesmodel pendingCasesmodelFromJson(String str) =>
    PendingCasesmodel.fromJson(json.decode(str));

String pendingCasesmodelToJson(PendingCasesmodel data) =>
    json.encode(data.toJson());

class PendingCasesmodel {
  PendingCasesmodel({
    required this.id,
    this.date,
    required this.day,
    required this.name,
  });

  String id;
  String? date;
  String day;
  String name;

  factory PendingCasesmodel.fromJson(Map<String, dynamic> json) =>
      PendingCasesmodel(
        id: json["id"],
        date: json["date"],
        day: json["day"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "day": day,
        "name": name,
      };
}
