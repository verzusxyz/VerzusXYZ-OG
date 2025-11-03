// To parse this JSON data, do
//
//     final guessDataModel = guessDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

GuessDataModel guessDataModelFromJson(String str) =>
    GuessDataModel.fromJson(json.decode(str));

String guessDataModelToJson(GuessDataModel data) => json.encode(data.toJson());

class GuessDataModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GuessDataModel({this.remark, this.status, this.message, this.data});

  factory GuessDataModel.fromJson(Map<String, dynamic> json) => GuessDataModel(
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
  Game? game;
  String? userBalance;
  String? gesBon;
  String? bonusPercent;
  String? winChance;
  List<String>? winPercent;

  Data({
    this.game,
    this.userBalance,
    this.gesBon,
    this.bonusPercent,
    this.winChance,
    this.winPercent,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    userBalance: json["userBalance"],
    gesBon: json["gesBon"].toString(),
    bonusPercent: json["bonusPercent "].toString(),
    winChance: json["winChance"].toString(),
    winPercent: json["winPercent"] == null
        ? []
        : List<String>.from(json["winPercent"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
    "userBalance": userBalance,
    "gesBon": gesBon,
    "bonusPercent ": bonusPercent,
    "winChance": winChance,
    "winPercent": winPercent == null
        ? []
        : List<dynamic>.from(winPercent!.map((x) => x)),
  };
}

class Game {
  int? id;
  String? name;
  String? alias;
  String? image;
  String? status;
  String? trending;
  String? featured;
  dynamic win;
  String? maxLimit;
  String? minLimit;
  String? investBack;
  dynamic probableWin;
  dynamic type;
  dynamic level;
  String? instruction;
  dynamic createdAt;
  String? updatedAt;

  Game({
    this.id,
    this.name,
    this.alias,
    this.image,
    this.status,
    this.trending,
    this.featured,
    this.win,
    this.maxLimit,
    this.minLimit,
    this.investBack,
    this.probableWin,
    this.type,
    this.level,
    this.instruction,
    this.createdAt,
    this.updatedAt,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["id"],
    name: json["name"],
    alias: json["alias"],
    image: json["image"],
    status: json["status"].toString(),
    trending: json["trending"].toString(),
    featured: json["featured"].toString(),
    win: json["win"],
    maxLimit: json["max_limit"].toString(),
    minLimit: json["min_limit"].toString(),
    investBack: json["invest_back"].toString(),
    probableWin: json["probable_win"].toString(),
    type: json["type"].toString(),
    level: json["level"].toString(),
    instruction: json["instruction"],
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alias": alias,
    "image": image,
    "status": status,
    "trending": trending,
    "featured": featured,
    "win": win,
    "max_limit": maxLimit,
    "min_limit": minLimit,
    "invest_back": investBack,
    "probable_win": probableWin,
    "type": type,
    "level": level,
    "instruction": instruction,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
