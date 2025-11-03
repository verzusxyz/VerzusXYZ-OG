// To parse this JSON data, do
//
//     final CardFindingResultModel = CardFindingResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

CardFindingResultModel CardFindingResultModelFromJson(String str) =>
    CardFindingResultModel.fromJson(json.decode(str));

String CardFindingResultModelToJson(CardFindingResultModel data) =>
    json.encode(data.toJson());

class CardFindingResultModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CardFindingResultModel({this.remark, this.status, this.message, this.data});

  factory CardFindingResultModel.fromJson(Map<String, dynamic> json) =>
      CardFindingResultModel(
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
  String? userChoose;
  String? bal;

  Data({this.message, this.type, this.result, this.userChoose, this.bal});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    type: json["type"],
    result: json["result"],
    userChoose: json["user_choose"],
    bal: json["bal"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "type": type,
    "result": result,
    "user_choose": userChoose,
    "bal": bal,
  };
}
