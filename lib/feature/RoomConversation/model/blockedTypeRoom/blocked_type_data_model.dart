import 'package:chato/feature/User/model/user_data.dart';
import 'package:chato/feature/User/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../BuyFeaturedUser/model/vip_data_model.dart';

part 'blocked_type_data_model.g.dart';

@JsonSerializable()
class BlockedTypeDataModel {
  final UserData? user;

  Map<String, dynamic> toJson() => _$BlockedTypeDataModelToJson(this);

  factory BlockedTypeDataModel.fromJson(Map<String, dynamic> json) =>
      _$BlockedTypeDataModelFromJson(json);

  BlockedTypeDataModel( {
    required this.user,

  });
}
