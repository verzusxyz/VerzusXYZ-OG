// To parse this JSON data, do
//
//     final KenoResultModel = KenoResultModelFromJson(jsonString);

import 'dart:convert';

KenoResultModel KenoResultModelFromJson(String str) => KenoResultModel.fromJson(json.decode(str));

String KenoResultModelToJson(KenoResultModel data) => json.encode(data.toJson());

class KenoResultModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    KenoResultModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory KenoResultModel.fromJson(Map<String, dynamic> json) => KenoResultModel(
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
    String? win;
    List<String>? result;
    String? userSelected;
    String? balance;

    Data({
        this.win,
        this.result,
        this.userSelected,
        this.balance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        win: json["win"].toString(),
        result: json["result"] == null ? [] : List<String>.from(json["result"]!.map((x) => x)),
        userSelected: json["user_selected"],
        balance: json["balance"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "win": win,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x)),
        "user_selected": userSelected,
        "balance": balance,
    };
}

class Message {
    List<String>? success;

    Message({
        this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
    };
}
