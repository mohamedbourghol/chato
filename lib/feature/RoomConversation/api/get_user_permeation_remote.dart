import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:chato/feature/RoomConversation/model/blockedTypeRoom/blocked_type_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/allType/all_type_model.dart';



abstract class UserPermeationDataSource {
  Future<Either<String,String>>
   getUserPermeation({
    required int roomId});
}

class UserPermeationDataSourceImpl extends
 UserPermeationDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  UserPermeationDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, String>>
  getUserPermeation({required int roomId}) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.roomPermeation,
          queryParameters: {
            'room':roomId
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );

        String res=json.decode(re.data)['data'];
        return Right(res);
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
