import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/backgroundImageRoom/background_image_model.dart';
import '../model/getGiftRoom/get_gift_model.dart';



abstract class GetGiftSource {
  Future<Either<String, GetGiftModel>>
  getGift();
}

class GetGiftSourceImpl extends
GetGiftSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  GetGiftSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, GetGiftModel>>
  getGift() async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.getGiftRoom,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return Right(GetGiftModel
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
