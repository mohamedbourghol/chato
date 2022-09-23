import 'package:json_annotation/json_annotation.dart';


part 'get_gift_data_model.g.dart';

@JsonSerializable()
class GetGiftDataModel {

  int? id;
  String? background;
  String? img;
  String? type;
  String? price;
  String? category;
  String? name;

  Map<String, dynamic> toJson() => _$GetGiftDataModelToJson(this);
  factory GetGiftDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetGiftDataModelFromJson(json);

  GetGiftDataModel(
      {
        required this.id,
        required this.background,
        required this.img,
        required this.type,
        required this.price,
        required this.category,
        required this.name
      });
}
