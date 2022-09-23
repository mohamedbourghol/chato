import 'package:json_annotation/json_annotation.dart';

part 'search_friend_data_model.g.dart';

@JsonSerializable()
class SearchFriendDataModel {

  String? img;
  int? id;
  String? name;



  Map<String, dynamic> toJson() => _$SearchFriendDataModelToJson(this);
  factory SearchFriendDataModel.fromJson(Map<String, dynamic> json) =>
      _$SearchFriendDataModelFromJson(json);

  SearchFriendDataModel(
      {
        required this.img,
        required this.id,
        required this.name,

      });
}
