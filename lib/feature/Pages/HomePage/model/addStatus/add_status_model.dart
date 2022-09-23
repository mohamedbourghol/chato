import 'package:json_annotation/json_annotation.dart';

part 'add_status_model.g.dart';

@JsonSerializable()
class AddStatusModel {

  bool? status;
  int? error_code;
  String? message;

  Map<String, dynamic> toJson() => _$AddStatusModelToJson(this);
  factory AddStatusModel.fromJson(Map<String, dynamic> json) =>
      _$AddStatusModelFromJson(json);

  AddStatusModel(
      {

        required this.error_code,
        required this.message,
        required this.status
      });
}
