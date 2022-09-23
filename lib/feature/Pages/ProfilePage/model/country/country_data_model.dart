import 'package:json_annotation/json_annotation.dart';

part 'country_data_model.g.dart';

@JsonSerializable()
class CountryDataModel {
  final int? id;
  final String? name_ar;
  final String? name_en;

  Map<String, dynamic> toJson() => _$CountryDataModelToJson(this);

  factory CountryDataModel.fromJson(Map<String, dynamic> json) =>
      _$CountryDataModelFromJson(json);

  CountryDataModel( {
    required this.id,
    required this.name_ar,
    required this.name_en,
  });
}
