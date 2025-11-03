// To parse this JSON data, do
//
//     final minesCashOutModel = minesCashOutModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

MinesCashOutModel minesCashOutModelFromJson(String str) =>
    MinesCashOutModel.fromJson(json.decode(str));

String minesCashOutModelToJson(MinesCashOutModel data) =>
    json.encode(data.toJson());

class MinesCashOutModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  MinesCashOutModel({this.remark, this.status, this.message, this.data});

  factory MinesCashOutModel.fromJson(Map<String, dynamic> json) =>
      MinesCashOutModel(
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
  String? balance;
  String? sound;
  String? success;

  Data({this.balance, this.sound, this.success});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    balance: json["balance"].toString(),
    sound: json["sound"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "sound": sound,
    "success": success,
  };
}
