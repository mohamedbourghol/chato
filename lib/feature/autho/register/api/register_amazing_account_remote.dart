import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../../../../core/utils/constants.dart';
import '../model/register_data_model.dart';
import '../model/register_model.dart';






abstract class RegisterAmazingAccountRemoteDataSource {
  Future<Either<String, RegisterModel>> registerAmazingAccount(
  {
  required  String name,
    required String email,
    required String password,
    required String password_confirmation,
    required int cost
}


      );

}

class RegisterAmazingAccountRemoteDataSourceImpl
    extends RegisterAmazingAccountRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;
  RegisterAmazingAccountRemoteDataSourceImpl({
    required this.dio,
    required this.networkInfo});

  @override
  Future<Either<String, RegisterModel>> registerAmazingAccount(
  {
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
    required int cost
}

      ) async {
    if (await networkInfo.hasConnection) {
      try {
      // dio.options.headers["authorization"] = "token ${Global.userToken}";
        final re = await dio.post(
          Endpoints.registerAmazingAccount,
          data: {
            "name":name,
            "email":email,
            "diamond_number":cost,
            "password":password,
            "password_confirmation":password_confirmation
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
        RegisterModel registerModel=RegisterModel.fromJson(json.decode(re.data));
        print(registerModel.message);
        return Right(RegisterModel.fromJson(json.decode(re.data)));
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
