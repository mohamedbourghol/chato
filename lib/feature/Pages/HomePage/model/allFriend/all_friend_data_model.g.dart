// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_friend_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllFriendDataModel _$AllFriendDataModelFromJson(Map<String, dynamic> json) =>
    AllFriendDataModel(
      img: json['img'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      vip_user: json['vip_user'] == null
          ? null
          : VipDataModel.fromJson(json['vip_user'] as Map<String, dynamic>),
      online: json['online'] as String?,
    );

Map<String, dynamic> _$AllFriendDataModelToJson(AllFriendDataModel instance) =>
    <String, dynamic>{
      'img': instance.img,
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'online': instance.online,
      'vip_user': instance.vip_user,
    };
