// To parse this JSON data, do
//
//     final blackJackAnswerModel = blackJackAnswerModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/login/login_response_model.dart';

BlackJackAnswerModel blackJackAnswerModelFromJson(String str) =>
    BlackJackAnswerModel.fromJson(json.decode(str));

String blackJackAnswerModelToJson(BlackJackAnswerModel data) =>
    json.encode(data.toJson());

class BlackJackAnswerModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  BlackJackAnswerModel({this.remark, this.status, this.message, this.data});

  factory BlackJackAnswerModel.fromJson(Map<String, dynamic> json) =>
      BlackJackAnswerModel(
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
  String? hiddenImage;
  String? winStatus;
  String? userSum;
  String? dealerSum;
  GameLog? gameLog;
  String? balance;

  Data({
    this.hiddenImage,
    this.winStatus,
    this.userSum,
    this.dealerSum,
    this.gameLog,
    this.balance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hiddenImage: json["hiddenImage"],
    winStatus: json["win_status"],
    userSum: json["userSum"].toString(),
    dealerSum: json["dealerSum"].toString(),
    gameLog: json["game_log"] == null
        ? null
        : GameLog.fromJson(json["game_log"]),
    balance: json["balance"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "hiddenImage": hiddenImage,
    "win_status": winStatus,
    "userSum": userSum,
    "dealerSum": dealerSum,
    "game_log": gameLog?.toJson(),
    "balance": balance,
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
  User? user;
  Game? game;

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
    this.user,
    this.game,
  });

  factory GameLog.fromJson(Map<String, dynamic> json) => GameLog(
    id: json["id"],
    userId: json["user_id"].toString(),
    gameId: json["game_id"].toString(),
    userSelect: json["user_select"],
    result: json["result"],
    status: json["status"].toString(),
    invest: json["invest"],
    winAmo: json["win_amo"].toString(),
    gameLogTry: json["try"].toString(),
    winStatus: json["win_status"].toString(),
    gameName: json["game_name"].toString(),
    mines: json["mines"].toString(),
    mineAvailable: json["mine_available"].toString(),
    goldCount: json["gold_count"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
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
    "user": user?.toJson(),
    "game": game?.toJson(),
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
    level: json["level"],
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
  String? verCodeSendAt;
  String? ts;
  String? tv;
  String? tsc;
  String? kv;
  String? profileComplete;
  String? banReason;
  String? createdAt;
  String? updatedAt;

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
    firstname: json["firstname"].toString(),
    lastname: json["lastname"].toString(),
    username: json["username"].toString(),
    email: json["email"].toString(),
    countryCode: json["country_code"].toString(),
    mobile: json["mobile"].toString(),
    refBy: json["ref_by"].toString(),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    status: json["status"].toString(),
    ev: json["ev"].toString(),
    sv: json["sv"].toString(),
    verCodeSendAt: json["ver_code_send_at"].toString(),
    ts: json["ts"].toString(),
    tv: json["tv"].toString(),
    tsc: json["tsc"].toString(),
    kv: json["kv"].toString(),
    profileComplete: json["profile_complete"].toString(),
    banReason: json["ban_reason"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
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
    "created_at": createdAt,
    "updated_at": updatedAt,
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
