// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockedUserData _$BlockedUserDataFromJson(Map<String, dynamic> json) =>
    BlockedUserData(
      token: json['token'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      img: json['img'] as String?,
      birth_date: json['birth_date'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$BlockedUserDataToJson(BlockedUserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'img': instance.img,
      'birth_date': instance.birth_date,
      'gender': instance.gender,
      'token': instance.token,
    };
