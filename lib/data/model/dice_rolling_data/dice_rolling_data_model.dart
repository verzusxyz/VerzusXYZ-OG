// To parse this JSON data, do
//
//     final diceRollingDataModel = diceRollingDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

DiceRollingDataModel diceRollingDataModelFromJson(String str) =>
    DiceRollingDataModel.fromJson(json.decode(str));

String diceRollingDataModelToJson(DiceRollingDataModel data) =>
    json.encode(data.toJson());

class DiceRollingDataModel {
  String? remark;
  String? status;
  Message? message;
  Datas? data;

  DiceRollingDataModel({this.remark, this.status, this.message, this.data});

  factory DiceRollingDataModel.fromJson(Map<String, dynamic> json) =>
      DiceRollingDataModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null
            ? null
            : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Datas.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "status": status,
    "message": message?.toJson(),
    "data": data?.toJson(),
  };
}

class Datas {
  Game? game;
  String? userBalance;
  dynamic imagePath;
  dynamic winChance;
  List<dynamic>? winPercent;
  dynamic gesBon;
  dynamic pokerImg;
  String? shortDesc;
  List<String>? cardFindingImgName;
  String? cardFindingImgPath;

  Datas({
    this.game,
    this.userBalance,
    this.imagePath,
    this.winChance,
    this.winPercent,
    this.gesBon,
    this.pokerImg,
    this.shortDesc,
    this.cardFindingImgName,
    this.cardFindingImgPath,
  });

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    userBalance: json["userBalance"],
    imagePath: json["image_path"],
    winChance: json["winChance"],
    winPercent: json["winPercent"] == null
        ? []
        : List<dynamic>.from(json["winPercent"]!.map((x) => x)),
    gesBon: json["gesBon"],
    pokerImg: json["pokerImg"],
    shortDesc: json["shortDesc"].toString(),
    cardFindingImgName: json["cardFindingImgName"] == null
        ? []
        : List<String>.from(json["cardFindingImgName"]!.map((x) => x)),
    cardFindingImgPath: json["cardFindingImgPath"],
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
    "userBalance": userBalance,
    "image_path": imagePath,
    "winChance": winChance,
    "winPercent": winPercent == null
        ? []
        : List<dynamic>.from(winPercent!.map((x) => x.toString())),
    "gesBon": gesBon,
    "pokerImg": pokerImg,
    "shortDesc": shortDesc,
    "cardFindingImgName": cardFindingImgName == null
        ? []
        : List<dynamic>.from(cardFindingImgName!.map((x) => x.toString())),
    "cardFindingImgPath": cardFindingImgPath,
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
  String? win;
  String? maxLimit;
  String? minLimit;
  String? investBack;
  String? probableWin;
  dynamic type;
  dynamic level;
  String? instruction;
  String? createdAt;
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
    maxLimit: json["max_limit"],
    minLimit: json["min_limit"],
    investBack: json["invest_back"].toString(),
    probableWin: json["probable_win"],
    type: json["type"],
    level: json["level"],
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
