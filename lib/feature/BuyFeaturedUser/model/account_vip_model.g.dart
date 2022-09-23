// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_vip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountVipModel _$AccountVipModelFromJson(Map<String, dynamic> json) =>
    AccountVipModel(
      id: json['id'] as int,
      name_en: json['name_en'] as String?,
      name_ar: json['name_ar'] as String?,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$AccountVipModelToJson(AccountVipModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.name_en,
      'name_ar': instance.name_ar,
      'img': instance.img,
    };
