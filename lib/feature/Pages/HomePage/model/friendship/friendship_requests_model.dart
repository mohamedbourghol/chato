import 'package:json_annotation/json_annotation.dart';

import 'friendship_requests_data_model.dart';



part 'friendship_requests_model.g.dart';

@JsonSerializable()
class FriendshipRequestsModel {

  bool? status;
  int? error_code;
  String? message;
  final List<FriendshipRequestsDataModel>? data;



  Map<String, dynamic> toJson() => _$FriendshipRequestsModelToJson(this);
  factory FriendshipRequestsModel.fromJson(Map<String, dynamic> json) =>
      _$FriendshipRequestsModelFromJson(json);

  FriendshipRequestsModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
