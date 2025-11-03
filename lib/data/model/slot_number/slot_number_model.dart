// To parse this JSON data, do
//
//     final slotNumberDataModel = slotNumberDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

SlotNumberDataModel slotNumberDataModelFromJson(String str) =>
    SlotNumberDataModel.fromJson(json.decode(str));

String slotNumberDataModelToJson(SlotNumberDataModel data) =>
    json.encode(data.toJson());

class SlotNumberDataModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SlotNumberDataModel({this.remark, this.status, this.message, this.data});

  factory SlotNumberDataModel.fromJson(Map<String, dynamic> json) =>
      SlotNumberDataModel(
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
  String? imagePath;
  String? userBalance;

  Data({this.game, this.imagePath, this.userBalance});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    imagePath: json["image_path"],
    userBalance: json["userBalance"],
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
    "image_path": imagePath,
    "userBalance": userBalance,
  };
}

class Game {
  int? id;
  String? name;
  String? alias;
  String? image;
  String? status;
  dynamic win;
  String? maxLimit;
  String? minLimit;
  String? investBack;
  List<String>? probableWin;
  dynamic type;
  List<String>? level;
  String? instruction;
  dynamic createdAt;
  DateTime? updatedAt;

  Game({
    this.id,
    this.name,
    this.alias,
    this.image,
    this.status,
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
    win: json["win"],
    maxLimit: json["max_limit"],
    minLimit: json["min_limit"],
    investBack: json["invest_back"].toString(),
    probableWin: json["probable_win"] == null
        ? []
        : List<String>.from(json["probable_win"]!.map((x) => x)),
    type: json["type"],
    level: json["level"] == null
        ? []
        : List<String>.from(json["level"]!.map((x) => x)),
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
    "win": win,
    "max_limit": maxLimit,
    "min_limit": minLimit,
    "invest_back": investBack,
    "probable_win": probableWin == null
        ? []
        : List<dynamic>.from(probableWin!.map((x) => x)),
    "type": type,
    "level": level == null ? [] : List<dynamic>.from(level!.map((x) => x)),
    "instruction": instruction,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
