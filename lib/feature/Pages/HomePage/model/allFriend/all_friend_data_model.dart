import 'package:json_annotation/json_annotation.dart';

import '../../../../BuyFeaturedUser/model/vip_data_model.dart';

part 'all_friend_data_model.g.dart';

@JsonSerializable()
class AllFriendDataModel {

  String? img;
  int? id;
  String? name;
  String? status;
  String?  online;
  VipDataModel?  vip_user;


  Map<String, dynamic> toJson() => _$AllFriendDataModelToJson(this);
  factory AllFriendDataModel.fromJson(Map<String, dynamic> json) =>
      _$AllFriendDataModelFromJson(json);

  AllFriendDataModel(
      {
        required this.img,
        required this.id,
        required this.name,
        required this.status,
        required this.vip_user,
        required this.online

      });
}
