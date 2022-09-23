// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFriendModel _$SearchFriendModelFromJson(Map<String, dynamic> json) =>
    SearchFriendModel(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => SearchFriendDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error_code: json['error_code'] as int?,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$SearchFriendModelToJson(SearchFriendModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error_code': instance.error_code,
      'message': instance.message,
      'data': instance.data,
    };
