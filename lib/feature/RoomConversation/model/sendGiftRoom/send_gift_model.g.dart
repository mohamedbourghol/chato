// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_gift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendGiftModel _$SendGiftModelFromJson(Map<String, dynamic> json) =>
    SendGiftModel(
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$SendGiftModelToJson(SendGiftModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
    };
