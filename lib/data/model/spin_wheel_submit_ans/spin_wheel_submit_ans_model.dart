// To parse this JSON data, do
//
//     final spinWheelSubmitAnsModel = spinWheelSubmitAnsModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

SpinWheelSubmitAnsModel spinWheelSubmitAnsModelFromJson(String str) =>
    SpinWheelSubmitAnsModel.fromJson(json.decode(str));

String spinWheelSubmitAnsModelToJson(SpinWheelSubmitAnsModel data) =>
    json.encode(data.toJson());

class SpinWheelSubmitAnsModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SpinWheelSubmitAnsModel({this.remark, this.status, this.message, this.data});

  factory SpinWheelSubmitAnsModel.fromJson(Map<String, dynamic> json) =>
      SpinWheelSubmitAnsModel(
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
  String? balance;
  String? invest;
  String? result;

  Data({this.gameLog, this.balance, this.invest, this.result});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLog: json["game_log"] == null
        ? null
        : GameLog.fromJson(json["game_log"]),
    balance: json["balance"].toString(),
    invest: json["invest"].toString(),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "game_log": gameLog?.toJson(),
    "balance": balance,
    "invest": invest,
    "result": result,
  };
}

class GameLog {
  int? userId;
  String? gameId;
  String? userSelect;
  String? result;
  String? status;
  dynamic winStatus;
  String? invest;
  dynamic winAmo;
  String? mines;
  String? mineAvailable;
  DateTime? updatedAt;
  DateTime? createdAt;
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
    userSelect: json["user_select"],
    result: json["result"],
    status: json["status"].toString(),
    winStatus: json["win_status"].toString(),
    invest: json["invest"].toString(),
    winAmo: json["win_amo"],
    mines: json["mines"].toString(),
    mineAvailable: json["mine_available"].toString(),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
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
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
