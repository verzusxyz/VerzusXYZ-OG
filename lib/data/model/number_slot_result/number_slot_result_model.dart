// To parse this JSON data, do
//
//     final slotNumberResultModel = slotNumberResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

SlotNumberResultModel slotNumberResultModelFromJson(String str) =>
    SlotNumberResultModel.fromJson(json.decode(str));

String slotNumberResultModelToJson(SlotNumberResultModel data) =>
    json.encode(data.toJson());

class SlotNumberResultModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SlotNumberResultModel({this.remark, this.status, this.message, this.data});

  factory SlotNumberResultModel.fromJson(Map<String, dynamic> json) =>
      SlotNumberResultModel(
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
  String? userChoose;
  String? message;
  String? type;
  String? bal;

  Data({this.userChoose, this.message, this.type, this.bal});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userChoose: json["user_choose"],
    message: json["message"],
    type: json["type"],
    bal: json["bal"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "user_choose": userChoose,
    "message": message,
    "type": type,
    "bal": bal,
  };
}
