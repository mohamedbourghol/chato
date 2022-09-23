import 'package:chato/feature/Pages/RoomPage/model/userRooms/user_room_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'fav_room_data_model.dart';






part 'fav_room_model.g.dart';

@JsonSerializable()
class FavRoomModel {
  bool? status;
  int? error_code;
  String? message;
  List<FavRoomDataModel> data;


  Map<String, dynamic> toJson() => _$FavRoomModelToJson(this);
  factory FavRoomModel.fromJson(Map<String, dynamic> json) =>
      _$FavRoomModelFromJson(json);

  FavRoomModel(
      {

        required this.error_code,
        required this.message,
        required this.status,
        required this.data
      });
}
