// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_remove_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRemoveModel _$AddRemoveModelFromJson(Map<String, dynamic> json) =>
    AddRemoveModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$AddRemoveModelToJson(AddRemoveModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
