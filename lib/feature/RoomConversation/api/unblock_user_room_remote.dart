import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../../Conversation/model/bloc_user_model.dart';

abstract class UnBlockUserRoomDataSource {
  Future<Either<String, BlockUserModel>>
  unblockUser({
    required int userId,
    required int roomId,
   });
}

class UnBlockUserRoomDataSourceImpl extends
UnBlockUserRoomDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  UnBlockUserRoomDataSourceImpl(
      {
        required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, BlockUserModel>>
  unblockUser({
    required int userId,
    required int roomId,
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"]
            ="Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.unblockUserRoom,
          data: {
            'user_unblock_id':userId,
            'room_id':roomId,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return  Right(BlockUserModel.fromJson(json.decode(re.data)) );
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
