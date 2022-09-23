import 'package:chato/feature/Pages/HomePage/model/search_friend/search_friend_data_model.dart';
import 'package:json_annotation/json_annotation.dart';





part 'search_friend_model.g.dart';

@JsonSerializable()
class SearchFriendModel {

  bool? status;
  int? error_code;
  String? message;
  final List<SearchFriendDataModel>? data;



  Map<String, dynamic> toJson() =>
      _$SearchFriendModelToJson(this);
  factory SearchFriendModel.fromJson(Map<String, dynamic> json) =>
      _$SearchFriendModelFromJson(json);

  SearchFriendModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
