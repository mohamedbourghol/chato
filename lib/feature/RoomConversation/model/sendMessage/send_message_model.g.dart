// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageModel _$SendMessageModelFromJson(Map<String, dynamic> json) =>
    SendMessageModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : SendMessageDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendMessageModelToJson(SendMessageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
