import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/update_coins_model.dart';



abstract class UpdateCoinsRemoteDataSource {
  Future<Either<String, UpdateCoinsModel>> updateCoins({
    required String type,
    required String quantity,
});
}

class UpdateCoinsRemoteDataSourceImpl extends UpdateCoinsRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  UpdateCoinsRemoteDataSourceImpl
      ({
        required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, UpdateCoinsModel>> updateCoins(
  {
    required String type,
    required String quantity,
   }
      ) async {
      if (await networkInfo.hasConnection) {
       try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.updateCoins,
          data: {
            'type':type,
            'quantity':quantity
           },
        );
        if(re.statusCode!>=200&&re.statusCode!<300)
          {
            return Right(UpdateCoinsModel.fromJson(json.decode(re.data)));
          }
        else{
          return Left(Er.error);
        }
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
      return Left(Er.error);
    }
  }

}
