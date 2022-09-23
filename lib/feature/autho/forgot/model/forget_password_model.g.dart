// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordModel _$ForgetPasswordModelFromJson(Map<String, dynamic> json) =>
    ForgetPasswordModel(
      data: json['data'] == null
          ? null
          : ForgetPasswordDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$ForgetPasswordModelToJson(
        ForgetPasswordModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
