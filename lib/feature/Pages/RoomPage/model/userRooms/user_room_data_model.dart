import 'package:json_annotation/json_annotation.dart';

import '../../../../User/model/user_data.dart';
import '../background_room_model.dart';






part 'user_room_data_model.g.dart';

@JsonSerializable()
class UserRoomDataModel {

  int? id;
  String? name;
  final String? favorite_room_count;
  final UserData? user;
  final BackgroundRoomModel? background;
  final String? img;



  Map<String, dynamic> toJson() => _$UserRoomDataModelToJson(this);
  factory UserRoomDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserRoomDataModelFromJson(json);

  UserRoomDataModel(
      {
        required this.id,
        required this.name,
        required this.user,
        required this.favorite_room_count,
        required this.background,
        required this.img
      });
}
