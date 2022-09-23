// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRoomModel _$CreateRoomModelFromJson(Map<String, dynamic> json) =>
    CreateRoomModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$CreateRoomModelToJson(CreateRoomModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
