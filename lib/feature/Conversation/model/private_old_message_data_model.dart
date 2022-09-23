import 'package:chato/feature/User/model/user_data.dart';
import 'package:json_annotation/json_annotation.dart';


part 'private_old_message_data_model.g.dart';


@JsonSerializable()
class PrivateOldMessageDataModel {


  int? id;
  String? conversation_id;
  String? message;
  String? all_file;
  String? localFile;
  String? seen;
  String? created_at;
  String? updated_at;
  UserData? user;

  Map<String, dynamic> toJson() => _$PrivateOldMessageDataModelToJson(this);
  factory PrivateOldMessageDataModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateOldMessageDataModelFromJson(json);

  PrivateOldMessageDataModel(
      {

        required this.conversation_id,
        required this.message,
        required this.seen,
        required this.created_at,
        required this.updated_at,
        required this.user,
        required this.id,
        required this.localFile,
        required this.all_file
      });
}
