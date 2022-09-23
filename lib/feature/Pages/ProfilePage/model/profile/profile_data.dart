import 'package:json_annotation/json_annotation.dart';

import '../country/country_data_model.dart';

part 'profile_data.g.dart';

@JsonSerializable()
class ProfileData {
  final int? id;
  final String? name;
  final String? email;
   String? img;
   String? birth_date;
   String? coins;
  String? diamond;
   String? gender;
  String? type;
  final String? token;
  final String? status;
   String? personal_status;
  CountryDataModel? country;
  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  ProfileData( {
    required this.token,
    required this.name,
    required this.email,
    required this.id,
    required this.img,
    required this.birth_date,
    required this.gender,
    required this.status,
    required this.country,
    required this.type,
    required this.personal_status,
    required this.coins,
    required this.diamond
  });
}
