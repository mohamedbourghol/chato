// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteUserModel _$DeleteUserModelFromJson(Map<String, dynamic> json) =>
    DeleteUserModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$DeleteUserModelToJson(DeleteUserModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
