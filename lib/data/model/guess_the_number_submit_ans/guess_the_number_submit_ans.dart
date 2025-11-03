// To parse this JSON data, do
//
//     final GuessTheNumberSubmitAnsModel = GuessTheNumberSubmitAnsModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

GuessTheNumberSubmitAnsModel GuessTheNumberSubmitAnsModelFromJson(String str) =>
    GuessTheNumberSubmitAnsModel.fromJson(json.decode(str));

String GuessTheNumberSubmitAnsModelToJson(GuessTheNumberSubmitAnsModel data) =>
    json.encode(data.toJson());

class GuessTheNumberSubmitAnsModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GuessTheNumberSubmitAnsModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GuessTheNumberSubmitAnsModel.fromJson(Map<String, dynamic> json) =>
      GuessTheNumberSubmitAnsModel(
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

  Data({this.gameLog, this.balance, this.invest});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLog: json["game_log"] == null
        ? null
        : GameLog.fromJson(json["game_log"]),
    balance: json["balance"].toString(),
    invest: json["invest"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "game_log": gameLog?.toJson(),
    "balance": balance,
    "invest": invest,
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
    winAmo: json["win_amo"],
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
