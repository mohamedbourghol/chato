import 'package:json_annotation/json_annotation.dart';

part 'add_trend_model.g.dart';

@JsonSerializable()
class AddTrendModel {

  bool? status;
  int? error_code;
  String? message;




  Map<String, dynamic> toJson() => _$AddTrendModelToJson(this);
  factory AddTrendModel.fromJson(Map<String, dynamic> json) =>
      _$AddTrendModelFromJson(json);


  AddTrendModel(
      {
        required this.error_code,
        required this.message,
        required this.status

      });
}
