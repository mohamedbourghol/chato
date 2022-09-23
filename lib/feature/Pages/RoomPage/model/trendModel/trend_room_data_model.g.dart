// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend_room_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendRoomDataModel _$TrendRoomDataModelFromJson(Map<String, dynamic> json) =>
    TrendRoomDataModel(
      id: json['id'] as int?,
      img: json['img'] as String?,
      background: json['background'] == null
          ? null
          : BackgroundRoomModel.fromJson(
              json['background'] as Map<String, dynamic>),
      favorite_room_count: json['favorite_room_count'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    )..name = json['name'] as String?;

Map<String, dynamic> _$TrendRoomDataModelToJson(TrendRoomDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'favorite_room_count': instance.favorite_room_count,
      'user': instance.user,
      'background': instance.background,
      'img': instance.img,
    };
