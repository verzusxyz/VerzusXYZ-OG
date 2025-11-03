import 'dart:convert';
import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

MinesGameInfoModel minesGameInfoModelFromJson(String str) =>
    MinesGameInfoModel.fromJson(json.decode(str));

String minesGameInfoModelToJson(MinesGameInfoModel data) =>
    json.encode(data.toJson());

class MinesGameInfoModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  MinesGameInfoModel({this.remark, this.status, this.message, this.data});

  factory MinesGameInfoModel.fromJson(Map<String, dynamic> json) =>
      MinesGameInfoModel(
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
  String? imagePath;
  String? gesBon;
  String? pokerImg;
  String? shortDesc;

  Data({
    this.game,
    this.userBalance,
    this.imagePath,
    this.gesBon,
    this.pokerImg,
    this.shortDesc,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    userBalance: json["userBalance"].toString(),
    imagePath: json["image_path"],
    gesBon: json["gesBon"].toString(),
    pokerImg: json["pokerImg"].toString(),
    shortDesc: json["shortDesc"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
    "userBalance": userBalance,
    "image_path": imagePath,
    "gesBon": gesBon,
    "pokerImg": pokerImg,
    "shortDesc": shortDesc,
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
  String? shortDesc;
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
    this.shortDesc,
    this.createdAt,
    this.updatedAt,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["id"],
    name: json["name"].toString(),
    alias: json["alias"].toString(),
    image: json["image"].toString(),
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
    shortDesc: json["short_desc"].toString(),
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
    "short_desc": shortDesc,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
