import 'package:json_annotation/json_annotation.dart';

import 'blocked_type_data_model.dart';

part 'blocked_type_model.g.dart';

@JsonSerializable()
class BlockedTypeModel {

  bool? status;
  int? error_code;
  String? message;
   List<BlockedTypeDataModel>? data;



  Map<String, dynamic> toJson() => _$BlockedTypeModelToJson(this);
  factory BlockedTypeModel.fromJson(Map<String, dynamic> json) =>
      _$BlockedTypeModelFromJson(json);

  BlockedTypeModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status

      });
}
