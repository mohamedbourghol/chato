import 'package:json_annotation/json_annotation.dart';


part 'change_permeation_user_model.g.dart';

@JsonSerializable()
class ChangePermeationModel {

  bool? status;
  int? error_code;
  String? message;




  Map<String, dynamic> toJson() => _$ChangePermeationModelToJson(this);
  factory ChangePermeationModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePermeationModelFromJson(json);

  ChangePermeationModel(
      {

        required this.error_code,
        required this.message,
        required this.status

      });
}
