import 'package:json_annotation/json_annotation.dart';


part 'update_user_info_model.g.dart';

@JsonSerializable()
class UpdateUserInfoModel {

  String? message;
  bool? status;
  int? error_code;

  Map<String, dynamic> toJson() => _$UpdateUserInfoModelToJson(this);
  factory UpdateUserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserInfoModelFromJson(json);

  UpdateUserInfoModel(
      {
        required this.message,
        required this.status,
        required this.error_code
      });
}