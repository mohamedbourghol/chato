// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_friend_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFriendData _$AddFriendDataFromJson(Map<String, dynamic> json) =>
    AddFriendData(
      id: json['id'] as int?,
      status: json['status'] as String?,
      friend_id: json['friend_id'] as int?,
      user_id: json['user_id'] as int?,
    );

Map<String, dynamic> _$AddFriendDataToJson(AddFriendData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'friend_id': instance.friend_id,
      'status': instance.status,
    };
