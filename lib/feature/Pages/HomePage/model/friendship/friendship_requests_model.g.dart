// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_requests_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendshipRequestsModel _$FriendshipRequestsModelFromJson(
        Map<String, dynamic> json) =>
    FriendshipRequestsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              FriendshipRequestsDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$FriendshipRequestsModelToJson(
        FriendshipRequestsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
