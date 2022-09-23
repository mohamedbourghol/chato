import 'dart:convert';

import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/resetPassword/reset_model.dart';



abstract class ResetPasswordRemoteDataSource {
  Future<Either<String, ResetModel>> resetPassword({
      required String oldPassword,
       required String password,
       required String confirmPassword
  });
}

class ResetPasswordRemoteDataSourceImpl extends ResetPasswordRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  ResetPasswordRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, ResetModel>> resetPassword({
    required String oldPassword,
    required String password,
    required String confirmPassword
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"]
        = "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.restPassword,
          data: {
            "password_old":oldPassword ,
            "password_new":password ,
            "confirm_password_new":confirmPassword ,

          },
         );
        return  Right(ResetModel.fromJson(json.decode(re.data)));
      } on DioError catch (ex) {
        if (ex.type == DioErrorType.connectTimeout) {
          return Left(Er.networkError);
        }
        else if (ex.type == DioErrorType.receiveTimeout) {
          return Left(Er.networkError);
        }
        return Left(Er.networkError);
      } catch (e) {
        return Left(Er.error);
      }
    }
    else {
      return Left(Er.networkError);
    }
  }


}
