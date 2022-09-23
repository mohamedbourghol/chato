import 'dart:convert';
import 'dart:io';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/addTrendRoom/add_trend_model.dart';
import '../model/allType/all_type_model.dart';
import '../model/sendMessage/send_message_model.dart';



abstract class AddTrendDataSource {
  Future<Either<String, AddTrendModel>>
   addTrendRoom({
    required String payment,
    required int roomId,
    required int count,
   });
}


class AddTrendDataSourceImpl extends
   AddTrendDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  AddTrendDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, AddTrendModel>>
  addTrendRoom({
    required String payment,
    required int roomId,
    required int count,

  }) async {

    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.addTrend,
          data: {
            'paymant':payment,
            'room_id':roomId,
             "x_number":count

          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return  Right(AddTrendModel.fromJson(json.decode(re.data)));
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
