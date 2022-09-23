import 'package:json_annotation/json_annotation.dart';

part 'blocked_user_data.g.dart';

@JsonSerializable()
class BlockedUserData {
  final int? id;
  final String? name;
  final String? email;
  final String? img;
  final String? birth_date;
  final String? gender;
  final String? token;

  Map<String, dynamic> toJson() => _$BlockedUserDataToJson(this);

  factory BlockedUserData.fromJson(Map<String, dynamic> json) =>
      _$BlockedUserDataFromJson(json);

  BlockedUserData( {
    required this.token,
    required this.name,
    required this.email,
    required this.id,
    required this.img,
    required this.birth_date,
    required this.gender,
  });
}
