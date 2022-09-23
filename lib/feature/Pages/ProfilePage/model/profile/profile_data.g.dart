// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      token: json['token'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      img: json['img'] as String?,
      birth_date: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      status: json['status'] as String?,
      country: json['country'] == null
          ? null
          : CountryDataModel.fromJson(json['country'] as Map<String, dynamic>),
      type: json['type'] as String?,
      personal_status: json['personal_status'] as String?,
      coins: json['coins'] as String?,
      diamond: json['diamond'] as String?,
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'img': instance.img,
      'birth_date': instance.birth_date,
      'coins': instance.coins,
      'diamond': instance.diamond,
      'gender': instance.gender,
      'type': instance.type,
      'token': instance.token,
      'status': instance.status,
      'personal_status': instance.personal_status,
      'country': instance.country,
    };
