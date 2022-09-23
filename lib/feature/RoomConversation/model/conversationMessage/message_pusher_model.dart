import 'package:chato/feature/User/model/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'conversation_old_message_data_model.dart';


part 'message_pusher_model.g.dart';


@JsonSerializable()
class MessagePusherModel {


  ConversationOldMessageDataModel msg;


  Map<String, dynamic> toJson() =>
      _$MessagePusherModelToJson(this);
  factory MessagePusherModel.fromJson(Map<String, dynamic> json) =>
      _$MessagePusherModelFromJson(json);

  MessagePusherModel(
      {

        required this.msg,

      });
}
