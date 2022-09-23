// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordDataModel _$ForgetPasswordDataModelFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordDataModel(
      email: json['email'] as String?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$ForgetPasswordDataModelToJson(
        ForgetPasswordDataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
