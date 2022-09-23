// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
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
      giftTransactionRecived: json['giftTransactionRecived'] as int?,
      giftTransactionSend: json['giftTransactionSend'] as int?,
      block: json['block'] as List<dynamic>?,
      friend: json['friend'] as List<dynamic>?,
      status: json['status'] as String?,
      viewers: json['viewers'],
      country: json['country'] == null
          ? null
          : CountryDataModel.fromJson(json['country'] as Map<String, dynamic>),
      personal_status: json['personal_status'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'img': instance.img,
      'status': instance.status,
      'personal_status': instance.personal_status,
      'birth_date': instance.birth_date,
      'gender': instance.gender,
      'token': instance.token,
      'giftTransactionSend': instance.giftTransactionSend,
      'giftTransactionRecived': instance.giftTransactionRecived,
      'friend': instance.friend,
      'block': instance.block,
      'viewers': instance.viewers,
      'vip_user': instance.vip_user,
      'country': instance.country,
    };
