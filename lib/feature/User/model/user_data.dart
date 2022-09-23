import 'package:chato/feature/Pages/ProfilePage/model/country/country_model.dart';
import 'package:chato/feature/User/model/user_friend.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../BuyFeaturedUser/model/vip_data_model.dart';
import '../../Pages/ProfilePage/model/country/country_data_model.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? img;
  final String? status;

  final String? personal_status;
  final String? birth_date;
  final String? gender;
  final String? token;
  final int?  giftTransactionSend;
  final int?  giftTransactionRecived;
  final List? friend;
  final List? block;
   var viewers;
  VipDataModel?  vip_user;
  CountryDataModel? country;
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  UserData( {
     this.token,
     this.name,
     this.email,
     this.id,
     this.img,
     this.birth_date,
     this.gender,
     this.vip_user,
    this.giftTransactionRecived,
    this.giftTransactionSend,
    this.block,
    this.friend,
    this.status,
    this.viewers,
    this.country,
    this.personal_status

  });
}
