// To parse this JSON data, do
//
//     final PokerInvestModel = PokerInvestModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

PokerInvestModel PokerInvestModelFromJson(String str) =>
    PokerInvestModel.fromJson(json.decode(str));

String PokerInvestModelToJson(PokerInvestModel data) =>
    json.encode(data.toJson());

class PokerInvestModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PokerInvestModel({this.remark, this.status, this.message, this.data});

  factory PokerInvestModel.fromJson(Map<String, dynamic> json) =>
      PokerInvestModel(
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
  int? gameLogId;
  String? balance;
  String? message;

  Data({this.gameLogId, this.balance, this.message});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLogId: json["game_log_id"],
    balance: json["balance"].toString(),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "game_log_id": gameLogId,
    "balance": balance,
    "message": message,
  };
}
