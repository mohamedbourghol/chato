import 'package:json_annotation/json_annotation.dart';

import 'country_data_model.dart';





part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  bool? status;
  int? error_code;
  String? message;
   List<CountryDataModel>? data;



  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  CountryModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status
      });
}
