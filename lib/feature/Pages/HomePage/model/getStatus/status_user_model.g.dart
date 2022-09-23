// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusUserModel _$StatusUserModelFromJson(Map<String, dynamic> json) =>
    StatusUserModel(
      seen: json['seen'] as String?,
      status: json['status'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$StatusUserModelToJson(StatusUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seen': instance.seen,
      'status': instance.status,
    };
