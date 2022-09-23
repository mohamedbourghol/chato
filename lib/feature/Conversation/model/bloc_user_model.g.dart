// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockUserModel _$BlockUserModelFromJson(Map<String, dynamic> json) =>
    BlockUserModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$BlockUserModelToJson(BlockUserModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
