import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:chato/feature/Pages/ProfilePage/model/countFriend/count_friend_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../model/blockedUser/blocked_user_model.dart';



abstract class BlockedUserRemoteDataSource {

  Future<Either<String, BlockedUserModel>> getBlockedUser();

}

class BlockedUserRemoteDataSourceImpl extends BlockedUserRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  BlockedUserRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, BlockedUserModel>> getBlockedUser() async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] = "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.getAllBlockUser,
          queryParameters: {
          },
        );

        return Right(BlockedUserModel.fromJson(json.decode(re.data)));
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
