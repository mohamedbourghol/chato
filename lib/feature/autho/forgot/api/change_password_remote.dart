import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../model/change_password_model.dart';
import '../model/forget_password_model.dart';




abstract class ChangePasswordRemoteDataSource {
  Future<Either<String, ChangePasswordModel>>
      changePassword({
    required String email,
    required String password,
    required String code,
  });
 }

class ChangePasswordRemoteDataSourceImpl extends
   ChangePasswordRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  ChangePasswordRemoteDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, ChangePasswordModel>>
  changePassword({
    required String email,
    required String password,
    required String code,}) async {
    if (await networkInfo.hasConnection) {
      try {
        final re = await dio.post
          (
          Endpoints.changePassword,
          data: {
            "email":email,
            "password":password,
            "code":code
          },
        );
        return Right(ChangePasswordModel.fromJson(json.decode(re.data)));
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
