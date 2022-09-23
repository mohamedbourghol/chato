import 'package:json_annotation/json_annotation.dart';
import 'get_gift_data_model.dart';

part 'get_gift_model.g.dart';

@JsonSerializable()
class GetGiftModel {

  bool? status;
  int? error_code;
  String? message;
  final List<GetGiftDataModel>? data;



  Map<String, dynamic> toJson() => _$GetGiftModelToJson(this);
  factory GetGiftModel.fromJson(Map<String, dynamic> json) =>
      _$GetGiftModelFromJson(json);

  GetGiftModel(
      {
        required this.data,
        required this.error_code,
        required this.message,
        required this.status

      });
}
