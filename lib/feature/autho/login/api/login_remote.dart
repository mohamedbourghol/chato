import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/utils/constants.dart';
import '../model/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<Either<String, LoginModel>> login({
    required String name,
    required String password,
  });
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  LoginRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<Either<String, LoginModel>> login({
    required String name,
    required String password,
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        // dio.options.headers["authorization"] = "token ${Global.userToken}";
        final re = await dio.post(
          Endpoints.login,
          data: {
            "name": name,
            "password": password,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        print("re");
        print(re);
        print("re");
        LoginModel loginModel = LoginModel.fromJson(json.decode(re.data));
        print(loginModel.message);
        if(loginModel.data!=null)
          {
            dio.options.headers["Authorization"] =
            "Bearer ${loginModel.data!.token}";
            try{
              String? token = await FirebaseMessaging.instance.getToken();
              dio.post(
                Endpoints.createDevice,
                data: {
                  "token": token,
                },
                options: Options(
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  },
                ),
              );
            }
            catch(e){

            }

          }
        return Right(LoginModel.fromJson(json.decode(re.data)));
      } on DioError catch (ex) {
        if (ex.type == DioErrorType.connectTimeout) {
          return Left(Er.networkError);
        } else if (ex.type == DioErrorType.receiveTimeout) {
          return Left(Er.networkError);
        }
        return Left(Er.networkError);
      } catch (e) {
        print(e);
        return Left(Er.error);
      }
    } else {
      return Left(Er.networkError);
    }
  }
}
