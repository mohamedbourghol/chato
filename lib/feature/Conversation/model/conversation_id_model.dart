import 'package:json_annotation/json_annotation.dart';




part 'conversation_id_model.g.dart';


@JsonSerializable()
class ConversationIdModel {

  String? conversation_id;



  Map<String, dynamic> toJson() =>
      _$ConversationIdModelToJson(this);
  factory ConversationIdModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationIdModelFromJson(json);

  ConversationIdModel(
      {
        required this.conversation_id,

      });
}
