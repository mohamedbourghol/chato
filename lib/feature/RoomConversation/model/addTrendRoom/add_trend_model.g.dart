// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_trend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTrendModel _$AddTrendModelFromJson(Map<String, dynamic> json) =>
    AddTrendModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$AddTrendModelToJson(AddTrendModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
