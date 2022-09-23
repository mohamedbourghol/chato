import 'dart:convert';
import 'package:chato/feature/Pages/ProfilePage/model/logout/logout_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../../../../core/utils/constants.dart';

abstract class LogoutRemoteDataSource {
  Future<Either<String, LogoutModel>> logout();
}

class LogoutRemoteDataSourceImpl extends LogoutRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  LogoutRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<Either<String, LogoutModel>> logout() async {
    if (await networkInfo.hasConnection) {
      try {
         dio.options.headers["authorization"] = "Bearer ${Global.userToken}";
        final re = await dio.post(
          Endpoints.logout,

        );
        print("re");
        print(re);
        print("re");
        LogoutModel? logoutModel = LogoutModel.fromJson(json.decode(re.data));
        print(logoutModel.message);
        return Right(logoutModel);
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
