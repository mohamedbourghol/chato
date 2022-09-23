import 'package:chato/feature/Pages/RoomPage/model/trendModel/trend_room_data_model.dart';
import 'package:chato/feature/Pages/RoomPage/model/userRooms/user_room_data_model.dart';
import 'package:json_annotation/json_annotation.dart';






part 'trend_room_model.g.dart';

@JsonSerializable()
class TrendRoomModel {
  bool? status;
  int? error_code;
  String? message;
  List<TrendRoomDataModel> data;


  Map<String, dynamic> toJson() => _$TrendRoomModelToJson(this);
  factory TrendRoomModel.fromJson(Map<String, dynamic> json) =>
      _$TrendRoomModelFromJson(json);

  TrendRoomModel(
      {

        required this.error_code,
        required this.message,
        required this.status,
        required this.data
      });
}
