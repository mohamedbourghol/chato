import 'package:chato/feature/User/model/data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_data.dart';


part 'user_model.g.dart';

@JsonSerializable()
class UserModel {

  bool? status;
  int? error_code;
  String? message;
  final Data? data;


  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
