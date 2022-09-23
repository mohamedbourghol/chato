// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_coins_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCoinsModel _$UpdateCoinsModelFromJson(Map<String, dynamic> json) =>
    UpdateCoinsModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$UpdateCoinsModelToJson(UpdateCoinsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
