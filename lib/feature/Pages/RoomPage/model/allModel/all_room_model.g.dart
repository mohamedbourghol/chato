// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllRoomModel _$AllRoomModelFromJson(Map<String, dynamic> json) => AllRoomModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>)
          .map((e) => AllRoomDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllRoomModelToJson(AllRoomModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
