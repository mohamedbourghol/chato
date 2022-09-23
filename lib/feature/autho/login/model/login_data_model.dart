import 'package:json_annotation/json_annotation.dart';

import '../../../BuyFeaturedUser/model/vip_data_model.dart';

part 'login_data_model.g.dart';

@JsonSerializable()
class LoginDataModel {

  int? id;
  String? name;
  String? email;
  String? token;
  String? img;
  String? coins;
  String? diamond;
  VipDataModel?  vip_user;

  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);
  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);

  LoginDataModel(
      {
        required this.id,
        required this.name,
        required this.email,
        required this.token,
        required this.img,
        required this.coins,
        required this.diamond,
        this.vip_user
      });
}