import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';



abstract class ChangeRequestsFriendRemoteDataSource {
  Future<Either<String, int>> changeRequestsFriend({
    required int id,required String status
});
}

class ChangeRequestsFriendRemoteDataSourceImpl extends ChangeRequestsFriendRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  ChangeRequestsFriendRemoteDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, int>> changeRequestsFriend(
  {
    required int id,required String status
   }

      ) async {
    if (await networkInfo.hasConnection) {
      try {
        print(id);
        print(status);
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.changeRequestsFriend,
          data: {
            'id':"$id",
            'status':status
           },

        );
        if(re.statusCode!>=200&&re.statusCode!<300)
          {
            return Right(re.statusCode!);
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
