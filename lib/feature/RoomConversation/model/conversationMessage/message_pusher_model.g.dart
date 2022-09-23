// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_pusher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagePusherModel _$MessagePusherModelFromJson(Map<String, dynamic> json) =>
    MessagePusherModel(
      msg: ConversationOldMessageDataModel.fromJson(
          json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessagePusherModelToJson(MessagePusherModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
    };
