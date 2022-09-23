import 'package:chato/feature/autho/register/model/register_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  bool? status;
  int? error_code;
   String? message;
  RegisterDataModel? data;


  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  RegisterModel(
      {
        required this.data,
        required this.message,
        required this.error_code,
        required this.status
      });
}