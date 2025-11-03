// To parse this JSON data, do
//
//     final rouletteDataModel = rouletteDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

RouletteDataModel rouletteDataModelFromJson(String str) =>
    RouletteDataModel.fromJson(json.decode(str));

String rouletteDataModelToJson(RouletteDataModel data) =>
    json.encode(data.toJson());

class RouletteDataModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  RouletteDataModel({this.remark, this.status, this.message, this.data});

  factory RouletteDataModel.fromJson(Map<String, dynamic> json) =>
      RouletteDataModel(
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
  Game? game;
  String? userBalance;
  dynamic gesBon;

  Data({this.game, this.userBalance, this.gesBon});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    userBalance: json["userBalance"],
    gesBon: json["gesBon"],
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
    "userBalance": userBalance,
    "gesBon": gesBon,
  };
}

class Game {
  int? id;
  String? name;
  String? alias;
  String? image;
  int? status;
  int? trending;
  int? featured;
  dynamic win;
  String? maxLimit;
  String? minLimit;
  int? investBack;
  dynamic probableWin;
  dynamic type;
  dynamic level;
  String? instruction;
  dynamic createdAt;
  DateTime? updatedAt;

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
    status: json["status"],
    trending: json["trending"],
    featured: json["featured"],
    win: json["win"],
    maxLimit: json["max_limit"],
    minLimit: json["min_limit"],
    investBack: json["invest_back"],
    probableWin: json["probable_win"],
    type: json["type"],
    level: json["level"],
    instruction: json["instruction"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
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
    "updated_at": updatedAt?.toIso8601String(),
  };
}
