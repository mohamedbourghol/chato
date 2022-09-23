import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:chato/feature/Conversation/model/get_conversation_id_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/private_old_message_model.dart';



abstract class GetConversationIdDataSource {
  Future<Either<String, GetConversationIdModel>>
   getConversationId({
   required int userId
  });
}

class GetConversationIdDataSourceImpl extends
GetConversationIdDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  GetConversationIdDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, GetConversationIdModel>>
  getConversationId({
    required int userId
  }) async {
    if (await networkInfo.hasConnection) {
      try {

        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.getConversationId,
          queryParameters: {
            "user_id":userId,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return Right(GetConversationIdModel
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
