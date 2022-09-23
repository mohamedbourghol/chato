import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../../Globals.dart';
import '../model/get_conversation_privet_model.dart';
import '../../../Conversation/model/private_old_message_model.dart';



  abstract class GetConversationPrivateDataSource {
  Future<Either<String, GetConversationPrivateModel>>
   getConversationPrivate();
}

class GetConversationPrivateDataSourceImpl extends
   GetConversationPrivateDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  GetConversationPrivateDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, GetConversationPrivateModel>>
  getConversationPrivate() async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.getConversationPrivet,
          queryParameters: {},
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return Right(GetConversationPrivateModel
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
        print(e);
        return Left(Er.error);
      }
    }
    else {
      return Left(Er.networkError);
    }
  }

}
