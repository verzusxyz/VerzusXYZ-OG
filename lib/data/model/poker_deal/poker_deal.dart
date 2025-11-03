// To parse this JSON data, do
//
//     final pokerDealModel = pokerDealModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

PokerDealModel pokerDealModelFromJson(String str) =>
    PokerDealModel.fromJson(json.decode(str));

String pokerDealModelToJson(PokerDealModel data) => json.encode(data.toJson());

class PokerDealModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PokerDealModel({this.remark, this.status, this.message, this.data});

  factory PokerDealModel.fromJson(Map<String, dynamic> json) => PokerDealModel(
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
  List<String>? result;
  String? path;

  Data({this.result, this.path});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null
        ? []
        : List<String>.from(json["result"]!.map((x) => x)),
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x)),
    "path": path,
  };
}
