import 'package:json_annotation/json_annotation.dart';

import 'get_conversation_id_data_model.dart';



part 'get_conversation_id_model.g.dart';


@JsonSerializable()
class GetConversationIdModel {
  bool? status;
  int? error_code;
  String? message;

  final List<GetConversationIdDataModel>? data;



  Map<String, dynamic> toJson() =>
      _$GetConversationIdModelToJson(this);
  factory GetConversationIdModel.fromJson(Map<String, dynamic> json) =>
      _$GetConversationIdModelFromJson(json);

  GetConversationIdModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status,

      });
}
