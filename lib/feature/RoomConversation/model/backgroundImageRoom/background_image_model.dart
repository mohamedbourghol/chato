import 'package:json_annotation/json_annotation.dart';
import 'background_image_data_model.dart';

part 'background_image_model.g.dart';

@JsonSerializable()
class BackgroundImageModel {

  bool? status;
  int? error_code;
  String? message;
  final List<BackgroundImageDataModel>? data;



  Map<String, dynamic> toJson() => _$BackgroundImageModelToJson(this);
  factory BackgroundImageModel.fromJson(Map<String, dynamic> json) =>
      _$BackgroundImageModelFromJson(json);

  BackgroundImageModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status

      });
}
