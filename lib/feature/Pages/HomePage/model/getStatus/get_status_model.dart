import 'package:json_annotation/json_annotation.dart';

import 'get_status_data_model.dart';




part 'get_status_model.g.dart';

@JsonSerializable()
class GetStatusModel {
  bool? status;
  int? error_code;
  String? message;
  final List<GetStatusDataModel>? data;



  Map<String, dynamic> toJson() => _$GetStatusModelToJson(this);
  factory GetStatusModel.fromJson(Map<String, dynamic> json) =>
      _$GetStatusModelFromJson(json);

  GetStatusModel(
      {

        required this.data,
        required this.error_code,
        required this.message,
        required this.status

      });
}
