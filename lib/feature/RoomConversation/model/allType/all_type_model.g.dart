// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTypeModel _$AllTypeModelFromJson(Map<String, dynamic> json) => AllTypeModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AllTypeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$AllTypeModelToJson(AllTypeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
