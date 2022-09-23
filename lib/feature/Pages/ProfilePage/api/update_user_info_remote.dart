import 'dart:convert';
import 'dart:io';
import 'package:chato/feature/Pages/ProfilePage/model/logout/logout_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../../../../core/utils/constants.dart';
import '../model/updateUser/update_user_info_model.dart';

abstract class UpdateUserInfoDataSource {
  Future<Either<String, UpdateUserInfoModel>>
  updateUser({String? name,
    String? gender,
    int? country_id,
    String? personalStatus,
    File? img,
    String? birth_date,
    String? online,
  });
}

class UpdateUserInfoDataSourceImpl extends
UpdateUserInfoDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  UpdateUserInfoDataSourceImpl({
    required this.dio, required this.networkInfo});

  @override
  Future<Either<String, UpdateUserInfoModel>>
  updateUser({String? name,String? gender,
    int? country_id,
    File? img,
    String? birth_date,
    String? personalStatus,
    String? online,
  }) async {
    if (await networkInfo.hasConnection) {
      try {
         dio.options.headers["authorization"] =
         "Bearer ${Global.userToken}";
         String fileName='';
         if(img!=null) {
           fileName = img.path.split('/').last;
         }

         FormData formData = FormData.fromMap({
           if(img!=null)
           "img":
           await MultipartFile.fromFile(img.path, filename:fileName),
           if(name!=null)
           'name': name,
           if(country_id!=null)
             'country_id':country_id,
           if(gender!=null)
             "gender":gender,
           if(birth_date!=null)
           "birth_date":birth_date,
           if(personalStatus!=null)
             "personal_status":personalStatus,
           if(online!=null)
             "online":online
         });
        final re = await dio.post(
          Endpoints.updateUserInfo,
          data: formData
        );
        print("re");
        print(re);
        print("re");

         UpdateUserInfoModel? updateUserInfoModel =
         UpdateUserInfoModel.fromJson(json.decode(re.data));
        print(updateUserInfoModel.message);
        return Right(updateUserInfoModel);
      } on DioError catch (ex) {
        if (ex.type == DioErrorType.connectTimeout) {
          return Left(Er.networkError);
        } else if (ex.type == DioErrorType.receiveTimeout) {
          return Left(Er.networkError);
        }
        return Left(Er.networkError);
      } catch (e) {
        return Left(Er.error);
      }
    } else {
      return Left(Er.networkError);
    }
  }
}
