// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_type_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockedTypeDataModel _$BlockedTypeDataModelFromJson(
        Map<String, dynamic> json) =>
    BlockedTypeDataModel(
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlockedTypeDataModelToJson(
        BlockedTypeDataModel instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
