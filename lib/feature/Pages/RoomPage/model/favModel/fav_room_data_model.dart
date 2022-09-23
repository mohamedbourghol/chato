import 'package:json_annotation/json_annotation.dart';

import '../../../../User/model/user_data.dart';
import '../background_room_model.dart';






part 'fav_room_data_model.g.dart';

@JsonSerializable()
class FavRoomDataModel {

  int? id;
  String? name;
  final String? favorite_room_count;
  final UserData? user;
  final BackgroundRoomModel? background;
  final String? img;



  Map<String, dynamic> toJson() => _$FavRoomDataModelToJson(this);
  factory FavRoomDataModel.fromJson(Map<String, dynamic> json) =>
      _$FavRoomDataModelFromJson(json);

  FavRoomDataModel(
      {
        required this.id,
        required this.name,
        required this.background,
        required this.favorite_room_count,
        required this.user,
        required this.img
      });
}
