import 'package:json_annotation/json_annotation.dart';

import 'profile_data.dart';


part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {

  bool? status;
  int? error_code;
  String? message;
  final ProfileData? data;



  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
