// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_status_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStatusDataModel _$GetStatusDataModelFromJson(Map<String, dynamic> json) =>
    GetStatusDataModel(
      img: json['img'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      status_users: (json['status_users'] as List<dynamic>?)
          ?.map((e) => StatusUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetStatusDataModelToJson(GetStatusDataModel instance) =>
    <String, dynamic>{
      'img': instance.img,
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'status_users': instance.status_users,
    };
