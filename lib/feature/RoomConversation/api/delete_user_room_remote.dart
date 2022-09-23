import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/deleteUserRoom/delete_user_model.dart';
import '../model/sendGiftRoom/send_gift_model.dart';




abstract class DeleteUserRoomDataSource {
  Future<Either<String, DeleteUserModel>>
  deleteUser({
    required int userId,
    required int roomId,



   });
}

class DeleteUserRoomDataSourceImpl extends
DeleteUserRoomDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  DeleteUserRoomDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, DeleteUserModel>>
  deleteUser({
    required int userId,
    required int roomId,

  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] ="Bearer ${Global.userToken}";
        final re = await dio.post
          (
          userId==0?Endpoints.userDeleteRoom:Endpoints.deleteUserRoom,
          data: {
            if(userId>0)
            'remove_user_id':userId,
            'room_id':roomId,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return  Right(DeleteUserModel.fromJson(json.decode(re.data)) );
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
