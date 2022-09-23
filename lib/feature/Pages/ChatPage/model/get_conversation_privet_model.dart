import 'package:json_annotation/json_annotation.dart';

import 'get_conversation_privet_data_model.dart';


part 'get_conversation_privet_model.g.dart';


@JsonSerializable()
class GetConversationPrivateModel {
  bool? status;
  int? error_code;
  String? message;

  final List<GetConversationPrivateDataModel>? data;



  Map<String, dynamic> toJson() =>
      _$GetConversationPrivateModelToJson(this);
  factory GetConversationPrivateModel.fromJson(Map<String, dynamic> json) =>
      _$GetConversationPrivateModelFromJson(json);

  GetConversationPrivateModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status,

      });
}
