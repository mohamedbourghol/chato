import 'dart:convert';
import 'package:chato/feature/User/model/add_friend_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../../../../core/utils/constants.dart';

abstract class AddFriendRemoteDataSource {
  Future<Either<String, AddFriendModel>> addFriend({required int id});
}

class AddFriendRemoteDataSourceImpl extends AddFriendRemoteDataSource{
  final Dio dio;
  final DataConnectionChecker networkInfo;

  AddFriendRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<Either<String, AddFriendModel>> addFriend({required int id  }) async {
    if (await networkInfo.hasConnection) {
      try {
         dio.options.headers["authorization"] = "Bearer ${Global.userToken}";
        final re = await dio.post(
          Endpoints.addFriend,
          data: {
            "friend_id" : id,
          },
          options: Options(
            followRedirects: false,

          ),
        );

        return Right(AddFriendModel.fromJson(json.decode(re.data)));
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
