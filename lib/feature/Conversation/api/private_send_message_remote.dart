import 'dart:convert';
import 'dart:io';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../../RoomConversation/model/sendMessage/send_message_model.dart';




abstract class PrivateSendMessageDataSource {
  Future<Either<String, SendMessageModel>>
   sendMessage({
    required String message,
    required int userTwoId,
     File? file,
   });
}

class PrivateSendMessageDataSourceImpl extends
   PrivateSendMessageDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  PrivateSendMessageDataSourceImpl(
      {
        required this.dio,
        required this.networkInfo,

      });

  @override
  Future<Either<String, SendMessageModel>>
  sendMessage({
    required String message,
    required int userTwoId,
    File? file,
  }) async {
    String fileName='';
    if(file!=null) {
      fileName =file.path.split('/').last;
    }
    FormData data =  FormData.fromMap(
        {
          if(file!=null)
          "all_file":
          await MultipartFile.
          fromFile(file.path, filename:fileName),
          'message':message,
          'user2_id':userTwoId,
        }
    );
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.sendMessage,
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return Right(SendMessageModel
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
