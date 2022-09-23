import 'package:chato/feature/autho/register/model/register_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'login_data_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  bool? status;
  int? error_code;
  String? message;
  LoginDataModel? data;


  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  LoginModel(
      {
        required this.data,
        required this.message,
        required this.error_code,
        required this.status
      });
}