import 'package:json_annotation/json_annotation.dart';

import 'private_old_message_data_model.dart';


part 'private_old_message_model.g.dart';


@JsonSerializable()
class PrivateOldMessageModel {
  bool? status;
  int? error_code;
  String? message;
   List<PrivateOldMessageDataModel>? data;
  String? next_page_url;


  Map<String, dynamic> toJson() =>
      _$PrivateOldMessageModelToJson(this);
  factory PrivateOldMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateOldMessageModelFromJson(json);

  PrivateOldMessageModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status,
        required this.next_page_url
      });
}
