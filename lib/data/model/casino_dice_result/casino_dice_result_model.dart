// To parse this JSON data, do
//
//     final casinoDiceResultModel = casinoDiceResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

CasinoDiceResultModel casinoDiceResultModelFromJson(String str) =>
    CasinoDiceResultModel.fromJson(json.decode(str));

String casinoDiceResultModelToJson(CasinoDiceResultModel data) =>
    json.encode(data.toJson());

class CasinoDiceResultModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CasinoDiceResultModel({this.remark, this.status, this.message, this.data});

  factory CasinoDiceResultModel.fromJson(Map<String, dynamic> json) =>
      CasinoDiceResultModel(
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
  String? result;
  String? win;
  String? balance;

  Data({this.result, this.win, this.balance});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"],
    win: json["win"].toString(),
    balance: json["balance"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "win": win,
    "balance": balance,
  };
}
