// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_old_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationOldMessageModel _$ConversationOldMessageModelFromJson(
        Map<String, dynamic> json) =>
    ConversationOldMessageModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ConversationOldMessageDataModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$ConversationOldMessageModelToJson(
        ConversationOldMessageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
