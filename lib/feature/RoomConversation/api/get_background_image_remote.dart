import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/backgroundImageRoom/background_image_model.dart';



abstract class GetBackgroundImageSource {
  Future<Either<String, BackgroundImageModel>>
   getBackgroundImage();
}

class GetBackgroundImageSourceImpl extends
GetBackgroundImageSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  GetBackgroundImageSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, BackgroundImageModel>>
  getBackgroundImage() async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.getBackgroundImage,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return Right(BackgroundImageModel
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
