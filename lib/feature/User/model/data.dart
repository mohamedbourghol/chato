import 'package:chato/feature/Pages/ProfilePage/model/country/country_model.dart';
import 'package:chato/feature/User/model/user_data.dart';
import 'package:chato/feature/User/model/user_friend.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../BuyFeaturedUser/model/vip_data_model.dart';
import '../../Pages/ProfilePage/model/country/country_data_model.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  final UserData? user;
  Map<String, dynamic> toJson() => _$DataToJson(this);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Data( {
     this.user
   });
}
