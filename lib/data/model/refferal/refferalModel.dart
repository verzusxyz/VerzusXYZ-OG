import 'dart:convert';

import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';

RefferalDataModel refferalDataModelFromJson(String str) =>
    RefferalDataModel.fromJson(json.decode(str));

String refferalDataModelToJson(RefferalDataModel data) =>
    json.encode(data.toJson());

class RefferalDataModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  RefferalDataModel({this.remark, this.status, this.message, this.data});

  factory RefferalDataModel.fromJson(Map<String, dynamic> json) =>
      RefferalDataModel(
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
  ReferralUsers? referralUsers;
  dynamic level;

  Data({this.referralUsers, this.level});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    referralUsers: json["referral_users"] == null
        ? null
        : ReferralUsers.fromJson(json["referral_users"]),
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "referral_users": referralUsers?.toJson(),
    "level": level,
  };
}

class ReferralUsers {
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
  List<ReferralUsers>? allReferrals;
  ReferralUsers? referrer;

  ReferralUsers({
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
    this.allReferrals,
    this.referrer,
  });

  factory ReferralUsers.fromJson(Map<String, dynamic> json) => ReferralUsers(
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
    allReferrals: json["all_referrals"] == null
        ? []
        : List<ReferralUsers>.from(
            json["all_referrals"]!.map((x) => ReferralUsers.fromJson(x)),
          ),
    referrer: json["referrer"] == null
        ? null
        : ReferralUsers.fromJson(json["referrer"]),
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
    "all_referrals": allReferrals == null
        ? []
        : List<dynamic>.from(allReferrals!.map((x) => x.toJson())),
    "referrer": referrer?.toJson(),
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
