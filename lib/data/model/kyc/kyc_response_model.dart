class KycResponseModel {
  final String? status;
  final String? message;
  final Map<String, dynamic>? data;

  KycResponseModel({this.status, this.message, this.data});

  factory KycResponseModel.fromJson(Map<String, dynamic> json) {
    return KycResponseModel(
      status: json['status'],
      message: json['message'],
      data: json,
    );
  }
}
