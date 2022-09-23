import 'package:json_annotation/json_annotation.dart';
part 'send_coins_model.g.dart';

@JsonSerializable()
class SendCoinsModel {

  String? message;
  bool? status;
  int? error_code;

  Map<String, dynamic> toJson() => _$SendCoinsModelToJson(this);
  factory SendCoinsModel.fromJson(Map<String, dynamic> json) =>
      _$SendCoinsModelFromJson(json);

  SendCoinsModel({
        required this.message,
        required this.status,
        required this.error_code
      });
}