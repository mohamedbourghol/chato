// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_gift_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGiftDataModel _$GetGiftDataModelFromJson(Map<String, dynamic> json) =>
    GetGiftDataModel(
      id: json['id'] as int?,
      background: json['background'] as String?,
      img: json['img'] as String?,
      type: json['type'] as String?,
      price: json['price'] as String?,
      category: json['category'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GetGiftDataModelToJson(GetGiftDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'background': instance.background,
      'img': instance.img,
      'type': instance.type,
      'price': instance.price,
      'category': instance.category,
      'name': instance.name,
    };
