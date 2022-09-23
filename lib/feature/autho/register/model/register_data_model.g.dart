// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDataModel _$RegisterDataModelFromJson(Map<String, dynamic> json) =>
    RegisterDataModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      img: json['img'] as String?,
      token: json['token'] as String?,
      diamond: json['diamond'] as String?,
      coins: json['coins'] as String?,
    );

Map<String, dynamic> _$RegisterDataModelToJson(RegisterDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
      'img': instance.img,
      'coins': instance.coins,
      'diamond': instance.diamond,
    };
