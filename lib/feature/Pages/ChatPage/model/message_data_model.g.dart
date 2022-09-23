// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDataModel _$MessageDataModelFromJson(Map<String, dynamic> json) =>
    MessageDataModel(
      message: json['message'] as String?,
      conversation_id: json['conversation_id'] as String,
    );

Map<String, dynamic> _$MessageDataModelToJson(MessageDataModel instance) =>
    <String, dynamic>{
      'conversation_id': instance.conversation_id,
      'message': instance.message,
    };
