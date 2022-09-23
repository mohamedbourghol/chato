// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFriend _$UserFriendFromJson(Map<String, dynamic> json) => UserFriend(
      id: json['id'] as int?,
      status: json['status'] as String?,
      friend_id: json['friend_id'] as String?,
      user_id: json['user_id'] as String?,
    );

Map<String, dynamic> _$UserFriendToJson(UserFriend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'friend_id': instance.friend_id,
      'status': instance.status,
    };
