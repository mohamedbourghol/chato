import 'package:json_annotation/json_annotation.dart';

import 'forget_password_data_model.dart';




part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordModel {
  bool? status;
  int? error_code;
  String? message;




  Map<String, dynamic> toJson() => _$ChangePasswordModelToJson(this);
  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordModelFromJson(json);

  ChangePasswordModel(
      {
        required this.error_code,
        required this.message,
        required this.status
      });
}
