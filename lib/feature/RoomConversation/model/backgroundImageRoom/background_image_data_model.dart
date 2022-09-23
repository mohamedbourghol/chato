import 'package:json_annotation/json_annotation.dart';





part 'background_image_data_model.g.dart';

@JsonSerializable()
class BackgroundImageDataModel {

  int? id;
  String? background;


  Map<String, dynamic> toJson() => _$BackgroundImageDataModelToJson(this);
  factory BackgroundImageDataModel.fromJson(Map<String, dynamic> json) =>
      _$BackgroundImageDataModelFromJson(json);

  BackgroundImageDataModel(
      {
        required this.id,
        required this.background,
      });
}
