// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserInfoModel _$UpdateUserInfoModelFromJson(Map<String, dynamic> json) =>
    UpdateUserInfoModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      error_code: json['error_code'] as int?,
    );

Map<String, dynamic> _$UpdateUserInfoModelToJson(
        UpdateUserInfoModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error_code': instance.error_code,
    };
