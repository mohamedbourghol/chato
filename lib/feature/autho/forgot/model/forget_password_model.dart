import 'package:json_annotation/json_annotation.dart';

import 'forget_password_data_model.dart';




part 'forget_password_model.g.dart';

@JsonSerializable()
class ForgetPasswordModel {
  bool? status;
  int? error_code;
  String? message;
  final ForgetPasswordDataModel? data;



  Map<String, dynamic> toJson() => _$ForgetPasswordModelToJson(this);
  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordModelFromJson(json);

  ForgetPasswordModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
