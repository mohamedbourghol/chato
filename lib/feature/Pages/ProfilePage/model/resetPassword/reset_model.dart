import 'package:json_annotation/json_annotation.dart';


part 'reset_model.g.dart';

@JsonSerializable()
class ResetModel {

  String? message;
  bool? status;
  int? error_code;

  Map<String, dynamic> toJson() => _$ResetModelToJson(this);
  factory ResetModel.fromJson(Map<String, dynamic> json) =>
      _$ResetModelFromJson(json);

  ResetModel(
      {
        required this.message,
        required this.status,
        required this.error_code
      });
}