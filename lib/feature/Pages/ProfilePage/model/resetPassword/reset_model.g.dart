// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetModel _$ResetModelFromJson(Map<String, dynamic> json) => ResetModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      error_code: json['error_code'] as int?,
    );

Map<String, dynamic> _$ResetModelToJson(ResetModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error_code': instance.error_code,
    };
