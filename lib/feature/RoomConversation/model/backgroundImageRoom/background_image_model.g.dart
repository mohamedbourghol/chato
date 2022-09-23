// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackgroundImageModel _$BackgroundImageModelFromJson(
        Map<String, dynamic> json) =>
    BackgroundImageModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              BackgroundImageDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$BackgroundImageModelToJson(
        BackgroundImageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
