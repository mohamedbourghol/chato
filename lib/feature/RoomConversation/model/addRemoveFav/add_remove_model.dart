import 'package:json_annotation/json_annotation.dart';


part 'add_remove_model.g.dart';

@JsonSerializable()
class AddRemoveModel {

  bool? status;
  int? error_code;
  String? message;




  Map<String, dynamic> toJson() => _$AddRemoveModelToJson(this);
  factory AddRemoveModel.fromJson(Map<String, dynamic> json) =>
      _$AddRemoveModelFromJson(json);

  AddRemoveModel(
      {

        required this.error_code,
        required this.message,
        required this.status

      });
}
