import 'package:chato/feature/Pages/RoomPage/model/userRooms/user_room_data_model.dart';
import 'package:json_annotation/json_annotation.dart';






part 'user_room_model.g.dart';

@JsonSerializable()
class UserRoomModel {
  bool? status;
  int? error_code;
  String? message;
  List<UserRoomDataModel> data;


  Map<String, dynamic> toJson() => _$UserRoomModelToJson(this);
  factory UserRoomModel.fromJson(Map<String, dynamic> json) =>
      _$UserRoomModelFromJson(json);

  UserRoomModel(
      {

        required this.error_code,
        required this.message,
        required this.status,
        required this.data
      });
}
