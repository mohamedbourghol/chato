// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_old_message_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationOldMessageDataModel _$ConversationOldMessageDataModelFromJson(
        Map<String, dynamic> json) =>
    ConversationOldMessageDataModel(
      id: json['id'] as int?,
      conversation_id: json['conversation_id'] as String?,
      message: json['message'] as String?,
      seen: json['seen'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      all_file: json['all_file'] as String?,
      localFile: json['localFile'] as String?,
      type: json['type'] as String?,
      text: json['text'] as String?,
      x_number: json['x_number'] as int?,
      name: json['name'] as String?,
      img: json['img'] as String?,
      room_id: json['room_id'] as int?,
      user_send: json['user_send'] as String?,
      gift: json['gift'] == null
          ? null
          : GetGiftDataModel.fromJson(json['gift'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationOldMessageDataModelToJson(
        ConversationOldMessageDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.room_id,
      'conversation_id': instance.conversation_id,
      'user_send': instance.user_send,
      'message': instance.message,
      'all_file': instance.all_file,
      'localFile': instance.localFile,
      'seen': instance.seen,
      'text': instance.text,
      'name': instance.name,
      'img': instance.img,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'user': instance.user,
      'x_number': instance.x_number,
      'type': instance.type,
      'gift': instance.gift,
    };
