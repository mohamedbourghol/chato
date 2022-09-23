// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStatusModel _$AddStatusModelFromJson(Map<String, dynamic> json) =>
    AddStatusModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$AddStatusModelToJson(AddStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
