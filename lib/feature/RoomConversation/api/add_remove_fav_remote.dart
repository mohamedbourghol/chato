import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/addRemoveFav/add_remove_model.dart';




abstract class AddRemoveFavDataSource {
  Future<Either<String, AddRemoveModel>>
  addRemoveFavRoom({
    required int roomId,

   });
}

class AddRemoveFavDataSourceImpl extends
AddRemoveFavDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  AddRemoveFavDataSourceImpl(
      {
        required this.dio,
        required this.networkInfo,

      });

  @override
  Future<Either<String, AddRemoveModel>>
  addRemoveFavRoom({

    required int roomId,

  }) async {


    FormData data =  FormData.fromMap(
        {
          'room_id':roomId,
        }
    );
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.addDeleteFavoriteRoom,
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return Right(AddRemoveModel
            .fromJson(json.decode(re.data)));
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
