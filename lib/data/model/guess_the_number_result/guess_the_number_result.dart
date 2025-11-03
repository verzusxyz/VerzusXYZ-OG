// To parse this JSON data, do
//
//     final guessTheNumberResultModel = guessTheNumberResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

GuessTheNumberResultModel guessTheNumberResultModelFromJson(String str) =>
    GuessTheNumberResultModel.fromJson(json.decode(str));

String guessTheNumberResultModelToJson(GuessTheNumberResultModel data) =>
    json.encode(data.toJson());

class GuessTheNumberResultModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GuessTheNumberResultModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GuessTheNumberResultModel.fromJson(Map<String, dynamic> json) =>
      GuessTheNumberResultModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null
            ? null
            : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "status": status,
    "message": message?.toJson(),
    "data": data?.toJson(),
  };
}

class Data {
  String? message;
  String? type;
  String? gameSt;
  String? winStatus;
  String? winNumber;
  String? bal;

  Data({
    this.message,
    this.type,
    this.gameSt,
    this.winStatus,
    this.winNumber,
    this.bal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    type: json["type"].toString(),
    gameSt: json["gameSt"].toString(),
    winStatus: json["win_status"].toString(),
    winNumber: json["win_number"],
    bal: json["bal"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "type": type,
    "gameSt": gameSt,
    "win_status": winStatus,
    "win_number": winNumber,
    "bal": bal,
  };
}
