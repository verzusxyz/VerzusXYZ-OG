// To parse this JSON data, do
//
//     final rouletteInvestModel = rouletteInvestModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

RouletteInvestModel rouletteInvestModelFromJson(String str) =>
    RouletteInvestModel.fromJson(json.decode(str));

String rouletteInvestModelToJson(RouletteInvestModel data) =>
    json.encode(data.toJson());

class RouletteInvestModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  RouletteInvestModel({this.remark, this.status, this.message, this.data});

  factory RouletteInvestModel.fromJson(Map<String, dynamic> json) =>
      RouletteInvestModel(
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
  String? winNum;
  int? winStatus;

  Data({this.gameLog, this.balance, this.winNum, this.winStatus});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      gameLog: json["game_log"] == null
          ? null
          : GameLog.fromJson(json["game_log"]),
      balance: json["balance"].toString(),
      winNum: json["win_num"].toString(),
      winStatus: json['win_status']);

  Map<String, dynamic> toJson() => {
    "game_log": gameLog?.toJson(),
    "balance": balance,
  };
}

class GameLog {
  int? userId;
  String? gameId;
  String? userSelect;
  String? result;
  String? status;
  String? invest;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? winStatus;

  GameLog({
    this.userId,
    this.gameId,
    this.userSelect,
    this.result,
    this.status,
    this.invest,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.winStatus,
  });

  factory GameLog.fromJson(Map<String, dynamic> json) => GameLog(
    userId: json["user_id"],
    gameId: json["game_id"].toString(),
    userSelect: json["user_select"],
    result: json["result"],
    status: json["status"].toString(),
    invest: json["invest"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
    winStatus: json['win_status'].toString(),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "game_id": gameId,
    "user_select": userSelect,
    "result": result,
    "status": status,
    "invest": invest,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
