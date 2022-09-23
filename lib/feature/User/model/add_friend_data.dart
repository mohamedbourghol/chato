import 'package:json_annotation/json_annotation.dart';

part 'add_friend_data.g.dart';

@JsonSerializable()
class AddFriendData {
  final int? id;
  final int? user_id;
  final int? friend_id;
  final String? status;

  Map<String, dynamic> toJson() => _$AddFriendDataToJson(this);

  factory AddFriendData.fromJson(Map<String, dynamic> json) =>
      _$AddFriendDataFromJson(json);

  AddFriendData( {
    required this.id,
    required this.status,
    required this.friend_id,
    required this.user_id
  });
}
