import 'package:chato/feature/User/model/user_data.dart';
import 'package:json_annotation/json_annotation.dart';


part 'message_data_model.g.dart';

@JsonSerializable()
  class MessageDataModel {


  String conversation_id;
  String? message;


  Map<String, dynamic> toJson() =>
      _$MessageDataModelToJson(this);
  factory MessageDataModel.fromJson(Map<String, dynamic> json) =>
      _$MessageDataModelFromJson(json);

  MessageDataModel(
      {

        required this.message,
           required this.conversation_id
      });
}
