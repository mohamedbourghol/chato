import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/friendship/friendship_requests_model.dart';



abstract class FriendshipRequestsRemoteDataSource {
  Future<Either<String, FriendshipRequestsModel>> friendshipRequests();
}

class FriendshipRequestsRemoteDataSourceImpl extends FriendshipRequestsRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  FriendshipRequestsRemoteDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, FriendshipRequestsModel>> friendshipRequests() async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.friendShipRequests,
          queryParameters: {
          },

        );
        return Right(FriendshipRequestsModel.fromJson(json.decode(re.data)));
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
