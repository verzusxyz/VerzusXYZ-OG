// To parse this JSON data, do
//
//     final rouletteAnswerModel = rouletteAnswerModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

RouletteAnswerModel rouletteAnswerModelFromJson(String str) =>
    RouletteAnswerModel.fromJson(json.decode(str));

String rouletteAnswerModelToJson(RouletteAnswerModel data) =>
    json.encode(data.toJson());

class RouletteAnswerModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  RouletteAnswerModel({this.remark, this.status, this.message, this.data});

  factory RouletteAnswerModel.fromJson(Map<String, dynamic> json) =>
      RouletteAnswerModel(
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
  String? message;
  String? type;
  String? result;
  String? userSelected;
  String? balance;

  Data({this.message, this.type, this.result, this.userSelected, this.balance});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"].toString(),
    type: json["type"].toString(),
    result: json["result"].toString(),
    userSelected: json["user_selected"].toString(),
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "type": type,
    "result": result,
    "user_selected": userSelected,
    "balance": balance,
  };
}
