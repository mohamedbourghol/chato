import 'package:json_annotation/json_annotation.dart';

part 'account_vip_model.g.dart';

@JsonSerializable()
class AccountVipModel {


  final  int id;
  final String? name_en;
  final  String? name_ar;
  final String? img;


  Map<String, dynamic> toJson() => _$AccountVipModelToJson(this);
  factory AccountVipModel.fromJson(Map<String, dynamic> json) =>
      _$AccountVipModelFromJson(json);

  AccountVipModel(
      {
        required this.id,
        required this.name_en,
        required this.name_ar,
        required this.img
      });
}

