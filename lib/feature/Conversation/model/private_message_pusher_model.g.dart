// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_message_pusher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateMessagePusherModel _$PrivateMessagePusherModelFromJson(
        Map<String, dynamic> json) =>
    PrivateMessagePusherModel(
      msg: PrivateOldMessageDataModel.fromJson(
          json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrivateMessagePusherModelToJson(
        PrivateMessagePusherModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
    };
