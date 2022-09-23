import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/changePermeationUser/change_permeation_user_model.dart';




abstract class ChangePermeationUserRoomDataSource {
  Future<Either<String, ChangePermeationModel>>
  changePermeationUser({required int userId,
    required int roomId,
    required String type

   });
}

class ChangePermeationUserRoomDataSourceImpl extends
ChangePermeationUserRoomDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  ChangePermeationUserRoomDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, ChangePermeationModel>>
  changePermeationUser({
    required int userId,
    required int roomId,
    required String type
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.changePermeationUserRoom,
          data: {
            'user_id':userId,
            'room_id':roomId,
            'type':type
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return  Right(
            ChangePermeationModel.fromJson(
                json.decode(re.data)
            )
        );
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
