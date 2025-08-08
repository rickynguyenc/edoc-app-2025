import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseModel {
  int? status;
  String? message;
  int? count;
  BaseModel({this.count, this.status, this.message});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      status: json['status'],
      message: json['message'],
      count: json['count'],
    );
  }
}
