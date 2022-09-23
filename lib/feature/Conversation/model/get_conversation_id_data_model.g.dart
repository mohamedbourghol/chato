// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_conversation_id_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConversationIdDataModel _$GetConversationIdDataModelFromJson(
        Map<String, dynamic> json) =>
    GetConversationIdDataModel(
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => ConversationIdModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConversationIdDataModelToJson(
        GetConversationIdDataModel instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
