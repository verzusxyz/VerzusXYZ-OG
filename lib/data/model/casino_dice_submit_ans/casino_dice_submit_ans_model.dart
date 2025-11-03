// To parse this JSON data, do
//
//     final casinoDiceSubmitAnsModel = casinoDiceSubmitAnsModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

CasinoDiceSubmitAnsModel casinoDiceSubmitAnsModelFromJson(String str) =>
    CasinoDiceSubmitAnsModel.fromJson(json.decode(str));

String casinoDiceSubmitAnsModelToJson(CasinoDiceSubmitAnsModel data) =>
    json.encode(data.toJson());

class CasinoDiceSubmitAnsModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CasinoDiceSubmitAnsModel({this.remark, this.status, this.message, this.data});

  factory CasinoDiceSubmitAnsModel.fromJson(Map<String, dynamic> json) =>
      CasinoDiceSubmitAnsModel(
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

  Data({this.gameLogId, this.balance});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLogId: json["gameLog_id"].toString(),
    balance: json["balance"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "gameLog_id": gameLogId,
    "balance": balance,
  };
}
