import 'package:json_annotation/json_annotation.dart';

part 'forget_password_data_model.g.dart';

@JsonSerializable()
class ForgetPasswordDataModel {

  String? email;
  int? code;


  Map<String, dynamic> toJson() => _$ForgetPasswordDataModelToJson(this);
  factory ForgetPasswordDataModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordDataModelFromJson(json);

  ForgetPasswordDataModel(
      {
        required this.email,
        required this.code,

      });
}
