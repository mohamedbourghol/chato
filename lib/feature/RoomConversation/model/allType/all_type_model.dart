import 'package:json_annotation/json_annotation.dart';

import 'all_type_data_model.dart';




part 'all_type_model.g.dart';

@JsonSerializable()
class AllTypeModel {

  bool? status;
  int? error_code;
  String? message;
   List<AllTypeDataModel>? data;



  Map<String, dynamic> toJson() => _$AllTypeModelToJson(this);
  factory AllTypeModel.fromJson(Map<String, dynamic> json) =>
      _$AllTypeModelFromJson(json);

  AllTypeModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status

      });
}
