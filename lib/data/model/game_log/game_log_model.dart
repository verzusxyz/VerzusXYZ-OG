// To parse this JSON data, do
//
//     final gameLogModel = gameLogModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

GameLogModel gameLogModelFromJson(String str) =>
    GameLogModel.fromJson(json.decode(str));

String gameLogModelToJson(GameLogModel data) => json.encode(data.toJson());

class GameLogModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GameLogModel({this.remark, this.status, this.message, this.data});

  factory GameLogModel.fromJson(Map<String, dynamic> json) => GameLogModel(
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
  List<GameLog>? gameLogs;

  Data({this.gameLogs});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gameLogs: json["game_logs"] == null
        ? []
        : List<GameLog>.from(
            json["game_logs"]!.map((x) => GameLog.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "game_logs": gameLogs == null
        ? []
        : List<dynamic>.from(gameLogs!.map((x) => x.toJson())),
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
    this.game,
  });

  factory GameLog.fromJson(Map<String, dynamic> json) => GameLog(
    id: json["id"],
    userId: json["user_id"].toString(),
    gameId: json["game_id"].toString(),
    userSelect: json["user_select"].toString(),
    result: json["result"].toString(),
    status: json["status"].toString(),
    invest: json["invest"].toString(),
    winAmo: json["win_amo"].toString(),
    gameLogTry: json["try"].toString(),
    winStatus: json["win_status"].toString(),
    gameName: json["game_name"].toString(),
    mines: json["mines"].toString(),
    mineAvailable: json["mine_available"].toString(),
    goldCount: json["gold_count"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
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
    type: json["type"],

    instruction: json["instruction"],
    shortDesc: json["short_desc"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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

    "instruction": instruction,
    "short_desc": shortDesc,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class GameLevel {
  String? maxSelectNumber;
  List<LevelElement>? levels;

  GameLevel({this.maxSelectNumber, this.levels});

  factory GameLevel.fromJson(Map<String, dynamic> json) => GameLevel(
    maxSelectNumber: json["max_select_number"],
    levels: json["levels"] == null
        ? null
        : List<LevelElement>.from(
            json["levels"].map((x) => LevelElement.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "max_select_number": maxSelectNumber,
    "levels": levels == null
        ? null
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
