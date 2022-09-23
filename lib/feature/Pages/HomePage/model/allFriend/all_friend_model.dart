import 'package:json_annotation/json_annotation.dart';

import 'all_friend_data_model.dart';




part 'all_friend_model.g.dart';

@JsonSerializable()
class AllFriendModel {
  bool? status;
  int? error_code;
  String? message;
  final List<AllFriendDataModel>? data;



  Map<String, dynamic> toJson() => _$AllFriendModelToJson(this);
  factory AllFriendModel.fromJson(Map<String, dynamic> json) =>
      _$AllFriendModelFromJson(json);

  AllFriendModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
