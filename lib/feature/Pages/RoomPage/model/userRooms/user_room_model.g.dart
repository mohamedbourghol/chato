// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoomModel _$UserRoomModelFromJson(Map<String, dynamic> json) =>
    UserRoomModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>)
          .map((e) => UserRoomDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserRoomModelToJson(UserRoomModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
