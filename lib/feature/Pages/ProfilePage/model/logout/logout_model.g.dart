// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutModel _$LogoutModelFromJson(Map<String, dynamic> json) => LogoutModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      error_code: json['error_code'] as int?,
    );

Map<String, dynamic> _$LogoutModelToJson(LogoutModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error_code': instance.error_code,
    };
