import 'package:chato/feature/Conversation/model/private_old_message_data_model.dart';

import 'package:json_annotation/json_annotation.dart';



part 'private_message_pusher_model.g.dart';


@JsonSerializable()
class PrivateMessagePusherModel {


  PrivateOldMessageDataModel msg;


  Map<String, dynamic> toJson() =>
      _$PrivateMessagePusherModelToJson(this);
  factory PrivateMessagePusherModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessagePusherModelFromJson(json);

  PrivateMessagePusherModel(
      {

        required this.msg,

      });
}
