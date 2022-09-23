// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountFriendModel _$CountFriendModelFromJson(Map<String, dynamic> json) =>
    CountFriendModel(
      data: json['data'] as int?,
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$CountFriendModelToJson(CountFriendModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
