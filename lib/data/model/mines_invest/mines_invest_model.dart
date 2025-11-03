// To parse this JSON data, do
//
//     final minesInvestModel = minesInvestModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

MinesInvestModel minesInvestModelFromJson(String str) =>
    MinesInvestModel.fromJson(json.decode(str));

String minesInvestModelToJson(MinesInvestModel data) =>
    json.encode(data.toJson());

class MinesInvestModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  MinesInvestModel({this.remark, this.status, this.message, this.data});

  factory MinesInvestModel.fromJson(Map<String, dynamic> json) =>
      MinesInvestModel(
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
  String? gameLogId;
  String? balance;
  String? random;
  String? availableMine;
  String? result;

  Data({
    this.gameLogId,
    this.balance,
    this.random,
    this.availableMine,
    this.result,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLogId: json["game_log_id"].toString(),
    balance: json["balance"].toString(),
    random: json["random"].toString(),
    availableMine: json["available_mine"].toString(),
    result: json["result"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "game_log_id": gameLogId,
    "balance": balance,
    "random": random,
    "available_mine": availableMine,
    "result": result,
  };
}
