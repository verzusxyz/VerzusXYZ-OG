// To parse this JSON data, do
//
//     final GameScreenModel = GameScreenModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

// ignore: non_constant_identifier_names
GameScreenModel GameScreenModelFromJson(String str) =>
    GameScreenModel.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String GameScreenModelToJson(GameScreenModel data) =>
    json.encode(data.toJson());

class GameScreenModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GameScreenModel({this.remark, this.status, this.message, this.data});

  factory GameScreenModel.fromJson(Map<String, dynamic> json) =>
      GameScreenModel(
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
  List<Game>? games;
  List<Games>? gamesTrending;
  List<Games>? gamesFeatured;
  User? user;
  Widget? widget;
  String? imagePath;

  Data({
    this.games,
    this.gamesTrending,
    this.gamesFeatured,
    this.user,
    this.widget,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    games: json["games"] == null
        ? []
        : List<Game>.from(json["games"]!.map((x) => Game.fromJson(x))),
    gamesTrending: json["gamesTrending"] == null
        ? []
        : List<Games>.from(
            json["gamesTrending"]!.map((x) => Games.fromJson(x)),
          ),
    gamesFeatured: json["gamesFeatured"] == null
        ? []
        : List<Games>.from(
            json["gamesFeatured"]!.map((x) => Games.fromJson(x)),
          ),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    widget: json["widget"] == null ? null : Widget.fromJson(json["widget"]),
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "games": games == null
        ? []
        : List<dynamic>.from(games!.map((x) => x.toJson())),
    "gamesTrending": gamesTrending == null
        ? []
        : List<dynamic>.from(gamesTrending!.map((x) => x.toJson())),
    "gamesFeatured": gamesFeatured == null
        ? []
        : List<dynamic>.from(gamesFeatured!.map((x) => x.toJson())),
    "user": user?.toJson(),
    "widget": widget?.toJson(),
    "image_path": imagePath,
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

class PurpleLevel {
  String? maxSelectNumber;
  List<LevelElement>? levels;

  PurpleLevel({this.maxSelectNumber, this.levels});

  factory PurpleLevel.fromJson(Map<String, dynamic> json) => PurpleLevel(
    maxSelectNumber: json["max_select_number"],
    levels: json["levels"] == null
        ? []
        : List<LevelElement>.from(
            json["levels"]!.map((x) => LevelElement.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "max_select_number": maxSelectNumber,
    "levels": levels == null
        ? []
        : List<dynamic>.from(levels!.map((x) => x.toJson())),
  };
}

class LevelElement {
  String? level;
  String? percent;

  LevelElement({this.level, this.percent});

  factory LevelElement.fromJson(Map<String, dynamic> json) =>
      LevelElement(level: json["level"], percent: json["percent"]);

  Map<String, dynamic> toJson() => {"level": level, "percent": percent};
}

class Games {
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
  dynamic createdAt;
  DateTime? updatedAt;

  Games({
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

  factory Games.fromJson(Map<String, dynamic> json) => Games(
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
    probableWin: json["probable_win"].toString(),
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

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? countryCode;
  String? mobile;
  String? refBy;
  Address? address;
  String? status;
  String? ev;
  String? sv;
  dynamic verCodeSendAt;
  String? ts;
  String? tv;
  dynamic tsc;
  String? kv;
  String? profileComplete;
  dynamic banReason;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.countryCode,
    this.mobile,
    this.refBy,
    this.address,
    this.status,
    this.ev,
    this.sv,
    this.verCodeSendAt,
    this.ts,
    this.tv,
    this.tsc,
    this.kv,
    this.profileComplete,
    this.banReason,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    refBy: json["ref_by"].toString(),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    status: json["status"].toString(),
    ev: json["ev"].toString(),
    sv: json["sv"].toString(),
    verCodeSendAt: json["ver_code_send_at"],
    ts: json["ts"].toString(),
    tv: json["tv"].toString(),
    tsc: json["tsc"],
    kv: json["kv"].toString(),
    profileComplete: json["profile_complete"].toString(),
    banReason: json["ban_reason"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "username": username,
    "email": email,
    "country_code": countryCode,
    "mobile": mobile,
    "ref_by": refBy,
    "address": address?.toJson(),
    "status": status,
    "ev": ev,
    "sv": sv,
    "ver_code_send_at": verCodeSendAt,
    "ts": ts,
    "tv": tv,
    "tsc": tsc,
    "kv": kv,
    "profile_complete": profileComplete,
    "ban_reason": banReason,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Address {
  String? country;
  String? address;
  String? state;
  String? zip;
  String? city;

  Address({this.country, this.address, this.state, this.zip, this.city});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"],
    address: json["address"],
    state: json["state"],
    zip: json["zip"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "address": address,
    "state": state,
    "zip": zip,
    "city": city,
  };
}

class Widget {
  String? totalBalance;
  String? name;

  Widget({this.totalBalance, this.name});

  factory Widget.fromJson(Map<String, dynamic> json) =>
      Widget(totalBalance: json["total_balance"], name: json["name"]);

  Map<String, dynamic> toJson() => {
    "total_balance": totalBalance,
    "name": name,
  };
}
