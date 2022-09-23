import 'package:json_annotation/json_annotation.dart';


part 'update_room_model.g.dart';

@JsonSerializable()
class UpdateRoomModel {

  bool? status;
  int? error_code;
  String? message;




  Map<String, dynamic> toJson() => _$UpdateRoomModelToJson(this);
  factory UpdateRoomModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateRoomModelFromJson(json);

  UpdateRoomModel(
      {

        required this.error_code,
        required this.message,
        required this.status

      });
}
