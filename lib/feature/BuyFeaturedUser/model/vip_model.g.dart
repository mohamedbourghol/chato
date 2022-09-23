// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VipModel _$VipModelFromJson(Map<String, dynamic> json) => VipModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : VipDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VipModelToJson(VipModel instance) => <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
