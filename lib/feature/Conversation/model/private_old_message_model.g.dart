// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_old_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateOldMessageModel _$PrivateOldMessageModelFromJson(
        Map<String, dynamic> json) =>
    PrivateOldMessageModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              PrivateOldMessageDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
      next_page_url: json['next_page_url'] as String?,
    );

Map<String, dynamic> _$PrivateOldMessageModelToJson(
        PrivateOldMessageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
      'next_page_url': instance.next_page_url,
    };
