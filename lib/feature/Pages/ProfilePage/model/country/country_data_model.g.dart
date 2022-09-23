// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDataModel _$CountryDataModelFromJson(Map<String, dynamic> json) =>
    CountryDataModel(
      id: json['id'] as int?,
      name_ar: json['name_ar'] as String?,
      name_en: json['name_en'] as String?,
    );

Map<String, dynamic> _$CountryDataModelToJson(CountryDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.name_ar,
      'name_en': instance.name_en,
    };
