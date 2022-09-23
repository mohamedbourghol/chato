import 'package:chato/feature/User/model/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../BuyFeaturedUser/model/vip_data_model.dart';

part 'all_type_data_model.g.dart';

@JsonSerializable()
class AllTypeDataModel {
  final int? id;
  final String? name;
  final String? email;
  final String? img;
  final String? birth_date;
  final String? gender;
  final String? token;
  VipDataModel? vip_user;

  Map<String, dynamic> toJson() => _$AllTypeDataModelToJson(this);

  factory AllTypeDataModel.fromJson(Map<String, dynamic> json) =>
      _$AllTypeDataModelFromJson(json);

  AllTypeDataModel( {
    required this.token,
    required this.name,
    required this.email,
    required this.id,
    required this.img,
    required this.birth_date,
    required this.gender,
    required this.vip_user


  });
}
