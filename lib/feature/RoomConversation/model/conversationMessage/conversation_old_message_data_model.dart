import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

import '../../../User/model/user_data.dart';
import '../getGiftRoom/get_gift_data_model.dart';


part 'conversation_old_message_data_model.g.dart';


@JsonSerializable()
class ConversationOldMessageDataModel {


  int? id;
  int? room_id;
  String? conversation_id;
  String? user_send;
  String? message;
  String? all_file;
  String? localFile;
  String? seen;
  String? text;
  String? name;
  String? img;
  String? created_at;
  String? updated_at;
  UserData? user;
 int? x_number;
 String? type;
  GetGiftDataModel? gift;
  /////pusher type
  Map<String, dynamic> toJson() => _$ConversationOldMessageDataModelToJson(this);
  factory ConversationOldMessageDataModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationOldMessageDataModelFromJson(json);

  ConversationOldMessageDataModel(
      {
         this.id,
         this.conversation_id,
         this.message,
         this.seen,
         this.created_at,
         this.updated_at,
         this.user,
        this.all_file,
        this.localFile,
        this.type,
        this.text,
        this.x_number,
        this.name,
        this.img,
        this.room_id,
        this.user_send,
        this.gift
      });
}
