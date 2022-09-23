import 'package:chato/feature/Pages/RoomPage/model/userRooms/user_room_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'all_room_data_model.dart';






part 'all_room_model.g.dart';

@JsonSerializable()
class AllRoomModel {
  bool? status;
  int? error_code;
  String? message;
  List<AllRoomDataModel> data;


  Map<String, dynamic> toJson() => _$AllRoomModelToJson(this);
  factory AllRoomModel.fromJson(Map<String, dynamic> json) =>
      _$AllRoomModelFromJson(json);

  AllRoomModel(
      {

        required this.error_code,
        required this.message,
        required this.status,
        required this.data
      });
}
