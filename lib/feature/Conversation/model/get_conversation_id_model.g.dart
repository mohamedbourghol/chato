// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_conversation_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConversationIdModel _$GetConversationIdModelFromJson(
        Map<String, dynamic> json) =>
    GetConversationIdModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              GetConversationIdDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$GetConversationIdModelToJson(
        GetConversationIdModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
