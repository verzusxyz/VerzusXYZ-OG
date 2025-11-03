// To parse this JSON data, do
//
//     final minesEndModel = minesEndModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

MinesEndModel minesEndModelFromJson(String str) =>
    MinesEndModel.fromJson(json.decode(str));

String minesEndModelToJson(MinesEndModel data) => json.encode(data.toJson());

class MinesEndModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  MinesEndModel({this.remark, this.status, this.message, this.data});

  factory MinesEndModel.fromJson(Map<String, dynamic> json) => MinesEndModel(
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
  String? type;
  String? sound;
  String? message;
  String? mines;
  String? mineAvailable;
  String? gameLogId;
  String? goldCount;
  String? mineImage;
  String? goldImage;
  String? goldTransparent;
  String? balance;

  Data({
    this.type,
    this.sound,
    this.message,
    this.mines,
    this.mineAvailable,
    this.gameLogId,
    this.goldCount,
    this.mineImage,
    this.goldImage,
    this.goldTransparent,
    this.balance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    sound: json["sound"],
    message: json["message"],
    mines: json["mines"].toString(),
    mineAvailable: json["mine_available"].toString(),
    gameLogId: json["game_log_id"].toString(),
    goldCount: json["gold_count"].toString(),
    mineImage: json["mine_image"].toString(),
    goldImage: json["gold_image"].toString(),
    goldTransparent: json["gold_transparent"],
    balance: json["balance"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "sound": sound,
    "message": message,
    "mines": mines,
    "mine_available": mineAvailable,
    "game_log_id": gameLogId,
    "gold_count": goldCount,
    "mine_image": mineImage,
    "gold_image": goldImage,
    "gold_transparent": goldTransparent,
    "balance": balance,
  };
}
