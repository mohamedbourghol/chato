import 'package:json_annotation/json_annotation.dart';


part 'delete_user_model.g.dart';

@JsonSerializable()
class DeleteUserModel {

  bool? status;
  int? error_code;
  String? message;




  Map<String, dynamic> toJson() => _$DeleteUserModelToJson(this);
  factory DeleteUserModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserModelFromJson(json);

  DeleteUserModel(
      {
        required this.error_code,
        required this.message,
        required this.status
      });
}
