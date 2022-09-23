// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendRoomModel _$TrendRoomModelFromJson(Map<String, dynamic> json) =>
    TrendRoomModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>)
          .map((e) => TrendRoomDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrendRoomModelToJson(TrendRoomModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
