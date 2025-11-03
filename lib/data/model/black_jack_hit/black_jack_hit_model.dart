// To parse this JSON data, do
//
//     final BlackJackHitModel = BlackJackHitModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

BlackJackHitModel BlackJackHitModelFromJson(String str) =>
    BlackJackHitModel.fromJson(json.decode(str));

String BlackJackHitModelToJson(BlackJackHitModel data) =>
    json.encode(data.toJson());

class BlackJackHitModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  BlackJackHitModel({this.remark, this.status, this.message, this.data});

  factory BlackJackHitModel.fromJson(Map<String, dynamic> json) =>
      BlackJackHitModel(
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
  String? dealerAceCount;
  String? userSum;
  String? userAceCount;
  List<String>? cardImg;
  GameLog? gameLog;
  List<String>? card;

  Data({
    this.dealerAceCount,
    this.userSum,
    this.userAceCount,
    this.cardImg,
    this.gameLog,
    this.card,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dealerAceCount: json["dealerAceCount"].toString(),
    userSum: json["userSum"].toString(),
    userAceCount: json["userAceCount"].toString(),
    cardImg: json["cardImg"] == null
        ? []
        : List<String>.from(json["cardImg"]!.map((x) => x.toString())),
    gameLog: json["game_log"] == null
        ? null
        : GameLog.fromJson(json["game_log"]),
    card: json["card"] == null
        ? []
        : List<String>.from(json["card"]!.map((x) => x.toString())),
  );

  Map<String, dynamic> toJson() => {
    "dealerAceCount": dealerAceCount,
    "userSum": userSum,
    "userAceCount": userAceCount,
    "cardImg": cardImg == null
        ? []
        : List<dynamic>.from(cardImg!.map((x) => x.toString())),
    "game_log": gameLog?.toJson(),
    "card": card == null
        ? []
        : List<dynamic>.from(card!.map((x) => x.toString())),
  };
}

class GameLog {
  int? id;
  String? userId;
  String? gameId;
  String? userSelect;
  String? result;
  String? status;
  String? invest;
  String? winAmo;
  String? gameLogTry;
  String? winStatus;
  String? gameName;
  String? mines;
  String? mineAvailable;
  String? goldCount;
  String? createdAt;
  String? updatedAt;

  GameLog({
    this.id,
    this.userId,
    this.gameId,
    this.userSelect,
    this.result,
    this.status,
    this.invest,
    this.winAmo,
    this.gameLogTry,
    this.winStatus,
    this.gameName,
    this.mines,
    this.mineAvailable,
    this.goldCount,
    this.createdAt,
    this.updatedAt,
  });

  factory GameLog.fromJson(Map<String, dynamic> json) => GameLog(
    id: json["id"],
    userId: json["user_id"].toString(),
    gameId: json["game_id"].toString(),
    userSelect: json["user_select"],
    result: json["result"],
    status: json["status"].toString(),
    invest: json["invest"],
    winAmo: json["win_amo"],
    gameLogTry: json["try"].toString(),
    winStatus: json["win_status"].toString(),
    gameName: json["game_name"],
    mines: json["mines"].toString(),
    mineAvailable: json["mine_available"].toString(),
    goldCount: json["gold_count"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "game_id": gameId,
    "user_select": userSelect,
    "result": result,
    "status": status,
    "invest": invest,
    "win_amo": winAmo,
    "try": gameLogTry,
    "win_status": winStatus,
    "game_name": gameName,
    "mines": mines,
    "mine_available": mineAvailable,
    "gold_count": goldCount,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
