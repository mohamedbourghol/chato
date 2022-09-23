// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_conversation_privet_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConversationPrivateDataModel _$GetConversationPrivateDataModelFromJson(
        Map<String, dynamic> json) =>
    GetConversationPrivateDataModel(
      message: json['message'] == null
          ? null
          : MessageDataModel.fromJson(json['message'] as Map<String, dynamic>),
      seen: json['seen'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user2: json['user2'] == null
          ? null
          : UserData.fromJson(json['user2'] as Map<String, dynamic>),
      user1: json['user1'] == null
          ? null
          : UserData.fromJson(json['user1'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetConversationPrivateDataModelToJson(
        GetConversationPrivateDataModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'seen': instance.seen,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'user2': instance.user2,
      'user1': instance.user1,
    };
