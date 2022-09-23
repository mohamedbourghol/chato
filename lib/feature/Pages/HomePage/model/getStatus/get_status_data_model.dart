import 'package:chato/feature/Pages/HomePage/model/getStatus/status_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_status_data_model.g.dart';

@JsonSerializable()
class GetStatusDataModel {

  String? img;
  int? id;
  String? name;
  String? status;
  List<StatusUserModel>?  status_users;



  Map<String, dynamic> toJson() => _$GetStatusDataModelToJson(this);
  factory GetStatusDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetStatusDataModelFromJson(json);

  GetStatusDataModel(
      {
        required this.img,
        required this.id,
        required this.name,
        required this.status,
        required this.status_users,


      });
}
