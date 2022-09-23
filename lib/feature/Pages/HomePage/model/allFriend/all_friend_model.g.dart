// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllFriendModel _$AllFriendModelFromJson(Map<String, dynamic> json) =>
    AllFriendModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AllFriendDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$AllFriendModelToJson(AllFriendModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
