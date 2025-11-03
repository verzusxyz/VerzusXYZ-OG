// To parse this JSON data, do
//
//     final pokerDataModel = pokerDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

PokerDataModel pokerDataModelFromJson(String str) =>
    PokerDataModel.fromJson(json.decode(str));

String pokerDataModelToJson(PokerDataModel data) => json.encode(data.toJson());

class PokerDataModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PokerDataModel({this.remark, this.status, this.message, this.data});

  factory PokerDataModel.fromJson(Map<String, dynamic> json) => PokerDataModel(
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
  String? imagePath;
  List<String>? gesBon;
  List<String>? pokerImg;

  Data({
    this.game,
    this.userBalance,
    this.imagePath,
    this.gesBon,
    this.pokerImg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    userBalance: json["userBalance"],
    imagePath: json["image_path"],
    gesBon: json["gesBon"] == null
        ? []
        : List<String>.from(json["gesBon"]!.map((x) => x)),
    pokerImg: json["pokerImg"] == null
        ? []
        : List<String>.from(json["pokerImg"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
    "userBalance": userBalance,
    "image_path": imagePath,
    "gesBon": gesBon == null ? [] : List<dynamic>.from(gesBon!.map((x) => x)),
    "pokerImg": pokerImg == null
        ? []
        : List<dynamic>.from(pokerImg!.map((x) => x)),
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
  String? type;
  String? level;
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
    win: json["win"].toString(),
    maxLimit: json["max_limit"].toString(),
    minLimit: json["min_limit"].toString(),
    investBack: json["invest_back"].toString(),
    probableWin: json["probable_win"].toString(),
    type: json["type"].toString(),
    level: json["level"].toString(),
    instruction: json["instruction"].toString(),
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
