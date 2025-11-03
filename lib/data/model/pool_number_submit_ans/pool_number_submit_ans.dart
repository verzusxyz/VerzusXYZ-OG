// To parse this JSON data, do
//
//     final poolNumbeSubmitAnsModel = poolNumbeSubmitAnsModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

PoolNumbeSubmitAnsModel poolNumbeSubmitAnsModelFromJson(String str) =>
    PoolNumbeSubmitAnsModel.fromJson(json.decode(str));

String poolNumbeSubmitAnsModelToJson(PoolNumbeSubmitAnsModel data) =>
    json.encode(data.toJson());

class PoolNumbeSubmitAnsModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PoolNumbeSubmitAnsModel({this.remark, this.status, this.message, this.data});

  factory PoolNumbeSubmitAnsModel.fromJson(Map<String, dynamic> json) =>
      PoolNumbeSubmitAnsModel(
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
  String? win;

  Data({this.gameLog, this.balance, this.invest, this.result, this.win});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLog: json["game_log"] == null
        ? null
        : GameLog.fromJson(json["game_log"]),
    balance: json["balance"].toString(),
    invest: json["invest"].toString(),
    result: json["result"].toString(),
    win: json["win"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "game_log": gameLog?.toJson(),
    "balance": balance,
    "invest": invest,
    "result": result.toString(),
    "win": win.toString(),
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
    userSelect: json["user_select"],
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
