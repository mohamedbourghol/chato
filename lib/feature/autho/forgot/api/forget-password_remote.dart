import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../model/forget_password_model.dart';




abstract class ForgetPasswordRemoteDataSource {
  Future<Either<String, ForgetPasswordModel>>
      forgetPassword({required String email});
 }

class ForgetPasswordRemoteDataSourceImpl extends
ForgetPasswordRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  ForgetPasswordRemoteDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, ForgetPasswordModel>>
      forgetPassword({required String email}) async {
    if (await networkInfo.hasConnection) {
      try {
        final re = await dio.post
          (
          Endpoints.forgetPassword,
          data: {
            "email":email
          },
        );
        return Right(ForgetPasswordModel.fromJson(json.decode(re.data)));
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
