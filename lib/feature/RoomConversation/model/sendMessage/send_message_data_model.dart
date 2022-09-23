import 'package:json_annotation/json_annotation.dart';


part 'send_message_data_model.g.dart';

@JsonSerializable()
class SendMessageDataModel {


  int? conversation_id;





  Map<String, dynamic> toJson() => _$SendMessageDataModelToJson(this);
  factory SendMessageDataModel.fromJson(Map<String, dynamic> json) =>
      _$SendMessageDataModelFromJson(json);

  SendMessageDataModel(
      {

        required this.conversation_id,


      });
}
