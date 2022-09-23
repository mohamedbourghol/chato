import 'package:json_annotation/json_annotation.dart';

import 'conversation_old_message_data_model.dart';


part 'conversation_old_message_model.g.dart';


@JsonSerializable()
class ConversationOldMessageModel {
  bool? status;
  int? error_code;
  String? message;
  final List<ConversationOldMessageDataModel>? data;



  Map<String, dynamic> toJson() => _$ConversationOldMessageModelToJson(this);
  factory ConversationOldMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationOldMessageModelFromJson(json);

  ConversationOldMessageModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
