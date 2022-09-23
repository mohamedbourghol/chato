// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavRoomModel _$FavRoomModelFromJson(Map<String, dynamic> json) => FavRoomModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>)
          .map((e) => FavRoomDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavRoomModelToJson(FavRoomModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
