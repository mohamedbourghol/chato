import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:chato/feature/Pages/ProfilePage/model/countFriend/count_friend_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../model/blockedUser/blocked_user_model.dart';



abstract class UnBlockedUserRemoteDataSource {
  Future<Either<String, String>> unBlockedUser({
 required int blockedId
  });
}

class UnBlockedUserRemoteDataSourceImpl extends UnBlockedUserRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  UnBlockedUserRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, String>> unBlockedUser({
    required  int blockedId
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"]
        = "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.unblockUser,
          data: { "blocked_id":blockedId },
         );

        return const Right('true');
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
