import 'package:json_annotation/json_annotation.dart';

import '../../../../BuyFeaturedUser/model/vip_data_model.dart';

part 'status_user_model.g.dart';

@JsonSerializable()
class StatusUserModel {
  int? id;
  String? seen;
  String? status;



  Map<String, dynamic> toJson() => _$StatusUserModelToJson(this);
  factory StatusUserModel.fromJson(Map<String, dynamic> json) =>
      _$StatusUserModelFromJson(json);

  StatusUserModel(
      {
        required this.seen,
        required this.status,
        required this.id


      });
}
