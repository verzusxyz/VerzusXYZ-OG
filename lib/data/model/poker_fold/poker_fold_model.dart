// To parse this JSON data, do
//
//     final PokerFoldModel = PokerFoldModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

// ignore: non_constant_identifier_names
PokerFoldModel PokerFoldModelFromJson(String str) =>
    PokerFoldModel.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String PokerFoldModelToJson(PokerFoldModel data) => json.encode(data.toJson());

class PokerFoldModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PokerFoldModel({this.remark, this.status, this.message, this.data});

  factory PokerFoldModel.fromJson(Map<String, dynamic> json) => PokerFoldModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
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
  String? sound;
  String? rank;
  List<String>? result;
  String? path;
  String? balance;

  Data({
    this.message,
    this.type,
    this.sound,
    this.rank,
    this.result,
    this.path,
    this.balance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    type: json["type"],
    sound: json["sound"],
    rank: json["rank"],
    result: json["result"] == null
        ? []
        : List<String>.from(json["result"]!.map((x) => x.toString())),
    path: json["path"],
    balance: json["balance"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "type": type,
    "sound": sound,
    "rank": rank,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toString())),
    "path": path,
    "balance": balance,
  };
}
