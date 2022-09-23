import 'dart:convert';
import 'dart:io';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/allType/all_type_model.dart';
import '../model/sendMessage/send_message_model.dart';



abstract class AddUserDataSource {
  Future<Either<String, String>>
   addUser({required int userId,
    required int roomId,

   });
}

class AddUserDataSourceImpl extends
   AddUserDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  AddUserDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, String>>
  addUser({
    required int userId,
    required int roomId,
    File? file,
  }) async {
    print("roomId");
    print(roomId);
    print("roomId");
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.addUserRoom,
          data: {
            'user_id':userId,
            'room_id':roomId
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return const Right('');
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
