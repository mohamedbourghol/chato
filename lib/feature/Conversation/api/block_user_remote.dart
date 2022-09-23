import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/bloc_user_model.dart';
import 'dart:convert';



abstract class BlockUserRemoteDataSource {
  Future<Either<String, String>> blockUser({
 required int blockedId
  });
}

class BlockUserRemoteDataSourceImpl extends BlockUserRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  BlockUserRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, String>> blockUser({
    required  int blockedId
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"]
        = "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.blockUser,
          data: { "blocked_id":blockedId },
         );
        BlockUserModel user=
        BlockUserModel.fromJson(json.decode(re.data));
       if(re.statusCode!>=200||re.statusCode!<=300)
        {
          return  Right(user.message);
        }
       else{
         return  Right(user.message);
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
      return Left(Er.networkError);
    }
  }


}
