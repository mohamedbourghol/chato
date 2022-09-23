// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_type_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTypeDataModel _$AllTypeDataModelFromJson(Map<String, dynamic> json) =>
    AllTypeDataModel(
      token: json['token'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      img: json['img'] as String?,
      birth_date: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      vip_user: json['vip_user'] == null
          ? null
          : VipDataModel.fromJson(json['vip_user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllTypeDataModelToJson(AllTypeDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'img': instance.img,
      'birth_date': instance.birth_date,
      'gender': instance.gender,
      'token': instance.token,
      'vip_user': instance.vip_user,
    };
