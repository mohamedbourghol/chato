import 'package:json_annotation/json_annotation.dart';

import 'conversation_id_model.dart';



part 'get_conversation_id_data_model.g.dart';


@JsonSerializable()
class GetConversationIdDataModel {


  final List<ConversationIdModel>? messages;



  Map<String, dynamic> toJson() =>
      _$GetConversationIdDataModelToJson(this);
  factory GetConversationIdDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetConversationIdDataModelFromJson(json);

  GetConversationIdDataModel(
      {
        required this.messages,
      });
}
