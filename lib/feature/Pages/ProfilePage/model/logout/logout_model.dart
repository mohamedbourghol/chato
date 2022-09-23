import 'package:json_annotation/json_annotation.dart';


part 'logout_model.g.dart';

@JsonSerializable()
class LogoutModel {

  String? message;
  bool? status;
  int? error_code;

  Map<String, dynamic> toJson() => _$LogoutModelToJson(this);
  factory LogoutModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutModelFromJson(json);

  LogoutModel(
      {
        required this.message,
        required this.status,
        required this.error_code
      });
}