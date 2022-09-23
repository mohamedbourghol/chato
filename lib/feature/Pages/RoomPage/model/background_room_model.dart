import 'package:json_annotation/json_annotation.dart';






part 'background_room_model.g.dart';

@JsonSerializable()
class BackgroundRoomModel {

  int? id;
  String? background;



  Map<String, dynamic> toJson() => _$BackgroundRoomModelToJson(this);
  factory BackgroundRoomModel.fromJson(Map<String, dynamic> json) =>
      _$BackgroundRoomModelFromJson(json);

  BackgroundRoomModel(
      {

        required this.id,
        required this.background,

      });
}
