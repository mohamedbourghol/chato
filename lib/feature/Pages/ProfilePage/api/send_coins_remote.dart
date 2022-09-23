import 'dart:convert';

import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/sendCoins/send_coins_model.dart';



abstract class SendCoinsRemoteDataSource {
  Future<Either<String, SendCoinsModel>> sendCoins({
     required String userReceivedId,
    required String numberOfCoinsOrDiamond,
    required String type,

  });
}

class SendCoinsRemoteDataSourceImpl extends SendCoinsRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  SendCoinsRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, SendCoinsModel>> sendCoins({
    required String userReceivedId,
    required String numberOfCoinsOrDiamond,
    required String type,
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"]
        = "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.sendCoins,
          data: {
            "user_received_id":userReceivedId,
            "number_of_coins_or_diamond":numberOfCoinsOrDiamond,
            "type":type
          },
         );
        return  Right(SendCoinsModel.fromJson(json.decode(re.data)));
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
