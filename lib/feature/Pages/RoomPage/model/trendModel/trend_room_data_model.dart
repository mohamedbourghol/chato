
import 'package:json_annotation/json_annotation.dart';

import '../../../../User/model/user_data.dart';
import '../background_room_model.dart';






part 'trend_room_data_model.g.dart';

@JsonSerializable()
class TrendRoomDataModel {

  int? id;

  String? name;
  final String? favorite_room_count;
  final UserData? user;
  final BackgroundRoomModel? background;
  final String? img;


  Map<String, dynamic> toJson() => _$TrendRoomDataModelToJson(this);
  factory TrendRoomDataModel.fromJson(Map<String, dynamic> json) =>
      _$TrendRoomDataModelFromJson(json);

  TrendRoomDataModel(
      {
        required this.id,

        required this.img,
        required this.background,
        required this.favorite_room_count,
        required this.user
      });
}
