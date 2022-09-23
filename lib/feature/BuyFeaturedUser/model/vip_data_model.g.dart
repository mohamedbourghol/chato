// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VipDataModel _$VipDataModelFromJson(Map<String, dynamic> json) => VipDataModel(
      vip_id: json['vip_id'],
      price: json['price'] as String?,
      end_date: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      start_date: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      account_vip: json['account_vip'] == null
          ? null
          : AccountVipModel.fromJson(
              json['account_vip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VipDataModelToJson(VipDataModel instance) =>
    <String, dynamic>{
      'vip_id': instance.vip_id,
      'price': instance.price,
      'end_date': instance.end_date?.toIso8601String(),
      'start_date': instance.start_date?.toIso8601String(),
      'account_vip': instance.account_vip,
    };
