// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataModel _$LoginDataModelFromJson(Map<String, dynamic> json) =>
    LoginDataModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      img: json['img'] as String?,
      coins: json['coins'] as String?,
      diamond: json['diamond'] as String?,
      vip_user: json['vip_user'] == null
          ? null
          : VipDataModel.fromJson(json['vip_user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDataModelToJson(LoginDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
      'img': instance.img,
      'coins': instance.coins,
      'diamond': instance.diamond,
      'vip_user': instance.vip_user,
    };
