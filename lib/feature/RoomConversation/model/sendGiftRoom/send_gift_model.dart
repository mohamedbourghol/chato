import 'package:json_annotation/json_annotation.dart';


part 'send_gift_model.g.dart';

@JsonSerializable()
class SendGiftModel {

  bool? status;
  int? error_code;
  String? message;




  Map<String, dynamic> toJson() => _$SendGiftModelToJson(this);
  factory SendGiftModel.fromJson(Map<String, dynamic> json) =>
      _$SendGiftModelFromJson(json);

  SendGiftModel(
      {

        required this.error_code,
        required this.message,
        required this.status

      });
}
