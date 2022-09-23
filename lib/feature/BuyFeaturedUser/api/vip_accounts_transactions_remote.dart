import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:chato/feature/Pages/ProfilePage/model/countFriend/count_friend_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../model/vip_model.dart';




abstract class VipAccountsTransactionsRemoteDataSource {

  Future<Either<String, VipModel>> vipAccountsTransactions({
    required int vipId,
  });

}

class VipAccountsTransactionsRemoteDataSourceImpl extends VipAccountsTransactionsRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  VipAccountsTransactionsRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, VipModel>> vipAccountsTransactions({
  required int vipId,
   }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.vipAccountsTransactions,
          data: {
            "vip_id" :vipId
          },
        );

        return Right(VipModel.fromJson(json.decode(re.data)));
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
