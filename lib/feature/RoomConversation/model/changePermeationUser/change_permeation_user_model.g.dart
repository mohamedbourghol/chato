// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_permeation_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePermeationModel _$ChangePermeationModelFromJson(
        Map<String, dynamic> json) =>
    ChangePermeationModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$ChangePermeationModelToJson(
        ChangePermeationModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
