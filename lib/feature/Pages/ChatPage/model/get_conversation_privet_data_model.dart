import 'package:chato/feature/User/model/user_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'message_data_model.dart';
part 'get_conversation_privet_data_model.g.dart';

@JsonSerializable()
  class GetConversationPrivateDataModel {



  MessageDataModel? message;
  String? seen;
  DateTime? created_at;
  DateTime? updated_at;
  UserData? user2;
  UserData? user1;

  Map<String, dynamic> toJson() =>
      _$GetConversationPrivateDataModelToJson(this);
  factory GetConversationPrivateDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetConversationPrivateDataModelFromJson(json);

  GetConversationPrivateDataModel(
      {

        required this.message,
        required this.seen,
        required this.created_at,
        required this.updated_at,
        required this.user2,
        required this.user1
      });
}
