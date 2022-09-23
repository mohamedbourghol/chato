import 'package:json_annotation/json_annotation.dart';

import 'add_friend_data.dart';


part 'add_friend_model.g.dart';

@JsonSerializable()
class AddFriendModel {
  bool? status;
  int? error_code;
  String? message;
  final AddFriendData? data;



  Map<String, dynamic> toJson() => _$AddFriendModelToJson(this);
  factory AddFriendModel.fromJson(Map<String, dynamic> json) =>
      _$AddFriendModelFromJson(json);

  AddFriendModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
