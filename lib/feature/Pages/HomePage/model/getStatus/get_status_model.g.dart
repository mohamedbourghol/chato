// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStatusModel _$GetStatusModelFromJson(Map<String, dynamic> json) =>
    GetStatusModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GetStatusDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$GetStatusModelToJson(GetStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
