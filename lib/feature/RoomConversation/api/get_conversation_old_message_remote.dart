import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/conversationMessage/conversation_old_message_model.dart';



abstract class ConversationOldMessageDataSource {
  Future<Either<String, ConversationOldMessageModel>>
   getConversationOldMessage({required int conversationId});
}

class ConversationOldMessageDataSourceImpl extends
      ConversationOldMessageDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  ConversationOldMessageDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, ConversationOldMessageModel>>
  getConversationOldMessage({required int conversationId}) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.getConversationOldMessage,
          queryParameters: {
            'room_id':conversationId,
            //'conversation_id':conversationId,

          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return Right(ConversationOldMessageModel
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
