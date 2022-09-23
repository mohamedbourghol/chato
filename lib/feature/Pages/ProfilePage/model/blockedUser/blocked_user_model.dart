import 'package:json_annotation/json_annotation.dart';

import 'blocked_user_data.dart';


part 'blocked_user_model.g.dart';

@JsonSerializable()
class BlockedUserModel {

  bool? status;
  int? error_code;
  String? message;
  final List<BlockedUserData>? data;



  Map<String, dynamic> toJson() => _$BlockedUserModelToJson(this);
  factory BlockedUserModel.fromJson(Map<String, dynamic> json) =>
      _$BlockedUserModelFromJson(json);

  BlockedUserModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
