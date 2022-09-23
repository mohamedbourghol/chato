import 'package:json_annotation/json_annotation.dart';

part 'user_friend.g.dart';

@JsonSerializable()
class UserFriend {
  final int? id;
  final String? user_id;
  final String? friend_id;
  final String? status;

  Map<String, dynamic> toJson() => _$UserFriendToJson(this);

  factory UserFriend.fromJson(Map<String, dynamic> json) =>
      _$UserFriendFromJson(json);

  UserFriend( {
    required this.id,
    required this.status,
    required this.friend_id,
    required this.user_id
  });
}
