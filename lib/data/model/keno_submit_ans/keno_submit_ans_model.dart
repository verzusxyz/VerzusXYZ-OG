// To parse this JSON data, do
//
//     final kenoSubmitAnsModel = kenoSubmitAnsModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

KenoSubmitAnsModel kenoSubmitAnsModelFromJson(String str) =>
    KenoSubmitAnsModel.fromJson(json.decode(str));

String kenoSubmitAnsModelToJson(KenoSubmitAnsModel data) =>
    json.encode(data.toJson());

class KenoSubmitAnsModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  KenoSubmitAnsModel({this.remark, this.status, this.message, this.data});

  factory KenoSubmitAnsModel.fromJson(Map<String, dynamic> json) =>
      KenoSubmitAnsModel(
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
  GameLog? gameLog;
  List<String>? userSelect;
  List<String>? matchNumber;
  String? balance;

  Data({this.gameLog, this.userSelect, this.matchNumber, this.balance});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLog: json["game_log"] == null
        ? null
        : GameLog.fromJson(json["game_log"]),
    userSelect: json["user_select"] == null
        ? []
        : List<String>.from(json["user_select"]!.map((x) => x.toString())),
    matchNumber: json["match_number"] == null
        ? []
        : List<String>.from(json["match_number"]!.map((x) => x.toString())),
    balance: json["balance"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "game_log": gameLog?.toJson(),
    "user_select": userSelect == null
        ? []
        : List<String>.from(userSelect!.map((x) => x.toString())),
    "match_number": matchNumber == null
        ? []
        : List<String>.from(matchNumber!.map((x) => x.toString())),
    "balance": balance,
  };
}

class GameLog {
  int? userId;
  String? gameId;
  String? userSelect;
  String? result;
  String? status;
  String? winStatus;
  String? invest;
  String? winAmo;
  String? mines;
  String? mineAvailable;
  String? updatedAt;
  String? createdAt;
  String? id;

  GameLog({
    this.userId,
    this.gameId,
    this.userSelect,
    this.result,
    this.status,
    this.winStatus,
    this.invest,
    this.winAmo,
    this.mines,
    this.mineAvailable,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory GameLog.fromJson(Map<String, dynamic> json) => GameLog(
    userId: json["user_id"],
    gameId: json["game_id"].toString(),
    userSelect: json["user_select"].toString(),
    result: json["result"].toString(),
    status: json["status"].toString(),
    winStatus: json["win_status"].toString(),
    invest: json["invest"].toString(),
    winAmo: json["win_amo"].toString(),
    mines: json["mines"].toString(),
    mineAvailable: json["mine_available"].toString(),
    updatedAt: json["updated_at"].toString(),
    createdAt: json["created_at"].toString(),
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "game_id": gameId,
    "user_select": userSelect,
    "result": result,
    "status": status,
    "win_status": winStatus,
    "invest": invest,
    "win_amo": winAmo,
    "mines": mines,
    "mine_available": mineAvailable,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
