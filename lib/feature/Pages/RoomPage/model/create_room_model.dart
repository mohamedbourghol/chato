import 'package:json_annotation/json_annotation.dart';






part 'create_room_model.g.dart';

@JsonSerializable()
class CreateRoomModel {
  bool? status;
  int? error_code;
  String? message;



  Map<String, dynamic> toJson() => _$CreateRoomModelToJson(this);
  factory CreateRoomModel.fromJson(Map<String, dynamic> json) =>
      _$CreateRoomModelFromJson(json);

  CreateRoomModel(
      {

        required this.error_code,
        required this.message,
        required this.status
      });
}
