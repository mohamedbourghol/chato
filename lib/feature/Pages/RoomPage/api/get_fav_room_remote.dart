import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/favModel/fav_room_model.dart';





abstract class GetFavRoomRemoteDataSource {
  Future<Either<String, FavRoomModel>> getFavRoom();
}

class GetFavRoomRemoteDataSourceImpl extends GetFavRoomRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  GetFavRoomRemoteDataSourceImpl
      ({
        required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, FavRoomModel>> getFavRoom() async {
      if (await networkInfo.hasConnection) {
       try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.getFavRoom,

        );
        if(re.statusCode!>=200&&re.statusCode!<300)
          {
            return Right(FavRoomModel.fromJson
              (json.decode(re.data)));
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
         print(e);
        return Left(Er.error);
      }
    }
    else {

      return Left(Er.error);
    }
  }

}
