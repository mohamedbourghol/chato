import 'package:json_annotation/json_annotation.dart';

part 'update_coins_model.g.dart';

@JsonSerializable()
class UpdateCoinsModel {
  bool? status;
  int? error_code;
  String? message;


  Map<String, dynamic> toJson() => _$UpdateCoinsModelToJson(this);
  factory UpdateCoinsModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateCoinsModelFromJson(json);

  UpdateCoinsModel(
      {
        required this.error_code,
        required this.message,
        required this.status,
      });
}
