// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_conversation_privet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConversationPrivateModel _$GetConversationPrivateModelFromJson(
        Map<String, dynamic> json) =>
    GetConversationPrivateModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GetConversationPrivateDataModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$GetConversationPrivateModelToJson(
        GetConversationPrivateModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
