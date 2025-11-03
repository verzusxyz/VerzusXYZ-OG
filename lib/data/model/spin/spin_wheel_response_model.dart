// To parse this JSON data, do
//
//     final spinWheelResponseModel = spinWheelResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

SpinWheelResponseModel spinWheelResponseModelFromJson(String str) =>
    SpinWheelResponseModel.fromJson(json.decode(str));

String spinWheelResponseModelToJson(SpinWheelResponseModel data) =>
    json.encode(data.toJson());

class SpinWheelResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SpinWheelResponseModel({this.remark, this.status, this.message, this.data});

  factory SpinWheelResponseModel.fromJson(Map<String, dynamic> json) =>
      SpinWheelResponseModel(
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
  List<String>? wheelElement;
  int? selectedValue;
  String? spinLogId;

  Data({this.wheelElement, this.selectedValue, this.spinLogId});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wheelElement: json["wheel_element"] == null
        ? []
        : List<String>.from(json["wheel_element"]!.map((x) => x)),
    selectedValue: json["selected_value"],
    spinLogId: json["spin_log_id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "wheel_element": wheelElement == null
        ? []
        : List<dynamic>.from(wheelElement!.map((x) => x)),
    "selected_value": selectedValue,
    "spin_log_id": spinLogId,
  };
}
