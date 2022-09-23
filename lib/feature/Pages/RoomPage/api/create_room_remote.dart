import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/create_room_model.dart';




abstract class CreateRoomRemoteDataSource {
  Future<Either<String, CreateRoomModel>> createRoom({
    required String name,
    required int coinsNumber
});
}

class CreateRoomRemoteDataSourceImpl extends CreateRoomRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  CreateRoomRemoteDataSourceImpl
      ({
        required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, CreateRoomModel>> createRoom(
  {
    required String name,
    required int coinsNumber
   }
      ) async {
      if (await networkInfo.hasConnection) {
       try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.createRoom,
          data: {
            'name':name,
            "coins_number":coinsNumber
           },
        );
        if(re.statusCode!>=200&&re.statusCode!<300)
          {
            return Right(CreateRoomModel.fromJson(json.decode(re.data)));
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
