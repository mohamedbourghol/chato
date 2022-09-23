import 'package:json_annotation/json_annotation.dart';

part 'friendship_requests_data_model.g.dart';

@JsonSerializable()
class FriendshipRequestsDataModel {

  String? img;
  int? id;
  String? name;



  Map<String, dynamic> toJson() => _$FriendshipRequestsDataModelToJson(this);
  factory FriendshipRequestsDataModel.fromJson(Map<String, dynamic> json) =>
      _$FriendshipRequestsDataModelFromJson(json);

  FriendshipRequestsDataModel(
      {
        required this.img,
        required this.id,
        required this.name,

      });
}
