import 'package:json_annotation/json_annotation.dart';

import 'private_old_message_data_model.dart';


part 'bloc_user_model.g.dart';


@JsonSerializable()
class BlockUserModel {
  bool? status;
  int? error_code;
  String message;




  Map<String, dynamic> toJson() =>
      _$BlockUserModelToJson(this);
  factory BlockUserModel.fromJson(Map<String, dynamic> json) =>
      _$BlockUserModelFromJson(json);

  BlockUserModel(
      {

        required this.error_code,
        required this.message,
        required this.status
      });
}
