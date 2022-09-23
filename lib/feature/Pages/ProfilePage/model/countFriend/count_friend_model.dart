import 'package:json_annotation/json_annotation.dart';

import '../profile/profile_data.dart';


part 'count_friend_model.g.dart';

@JsonSerializable()
class CountFriendModel {

   bool? status;
   int? error_code;
   String? message;
   int? data;



  Map<String, dynamic> toJson() => _$CountFriendModelToJson(this);
  factory CountFriendModel.fromJson(Map<String, dynamic> json) =>
      _$CountFriendModelFromJson(json);

  CountFriendModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}













