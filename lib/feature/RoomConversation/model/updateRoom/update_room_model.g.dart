// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateRoomModel _$UpdateRoomModelFromJson(Map<String, dynamic> json) =>
    UpdateRoomModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$UpdateRoomModelToJson(UpdateRoomModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
