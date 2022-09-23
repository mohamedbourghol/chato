import 'package:chato/feature/BuyFeaturedUser/model/vip_data_model.dart';
import 'package:chato/feature/Pages/RoomPage/model/userRooms/user_room_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vip_model.g.dart';

@JsonSerializable()
class VipModel {
  bool? status;
  int? error_code;
  String? message;
  VipDataModel? data;


  Map<String, dynamic> toJson() => _$VipModelToJson(this);
  factory VipModel.fromJson(Map<String, dynamic> json) =>
      _$VipModelFromJson(json);

  VipModel(
      {

        required this.error_code,
        required this.message,
        required this.status,
        required this.data
      });
}
