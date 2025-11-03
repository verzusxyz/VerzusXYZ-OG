// To parse this JSON data, do
//
//     final blackJackInvestModel = blackJackInvestModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

BlackJackInvestModel blackJackInvestModelFromJson(String str) =>
    BlackJackInvestModel.fromJson(json.decode(str));

String blackJackInvestModelToJson(BlackJackInvestModel data) =>
    json.encode(data.toJson());

class BlackJackInvestModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  BlackJackInvestModel({this.remark, this.status, this.message, this.data});

  factory BlackJackInvestModel.fromJson(Map<String, dynamic> json) =>
      BlackJackInvestModel(
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
  String? dealerSum;
  String? dealerAceCount;
  String? userSum;
  String? userAceCount;
  List<String>? dealerCardImg;
  List<String>? cardImg;
  GameLog? gameLog;
  String? balance;
  List<String>? card;
  String? imagePath;

  Data({
    this.dealerSum,
    this.dealerAceCount,
    this.userSum,
    this.userAceCount,
    this.dealerCardImg,
    this.cardImg,
    this.gameLog,
    this.balance,
    this.card,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dealerSum: json["dealerSum"].toString(),
    dealerAceCount: json["dealerAceCount"].toString(),
    userSum: json["userSum"].toString(),
    userAceCount: json["userAceCount"].toString(),
    dealerCardImg: json["dealerCardImg"] == null
        ? []
        : List<String>.from(json["dealerCardImg"]!.map((x) => x.toString())),
    cardImg: json["cardImg"] == null
        ? []
        : List<String>.from(json["cardImg"]!.map((x) => x.toString())),
    gameLog: json["game_log"] == null
        ? null
        : GameLog.fromJson(json["game_log"]),
    balance: json["balance"].toString(),
    card: json["card"] == null
        ? []
        : List<String>.from(json["card"]!.map((x) => x.toString())),
    imagePath: json["image_path"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "dealerSum": dealerSum,
    "dealerAceCount": dealerAceCount,
    "userSum": userSum,
    "userAceCount": userAceCount,
    "dealerCardImg": dealerCardImg == null
        ? []
        : List<dynamic>.from(dealerCardImg!.map((x) => x)),
    "cardImg": cardImg == null
        ? []
        : List<dynamic>.from(cardImg!.map((x) => x)),
    "game_log": gameLog?.toJson(),
    "balance": balance,
    "card": card == null ? [] : List<dynamic>.from(card!.map((x) => x)),
    "image_path": imagePath,
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
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
