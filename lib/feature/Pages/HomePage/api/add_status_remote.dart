import 'dart:convert';
import 'dart:io';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/addStatus/add_status_model.dart';



abstract class AddStatusRemoteDataSource {
  Future<Either<String, AddStatusModel>> addStatus({
   required File status
});
}

class AddStatusRemoteDataSourceImpl extends AddStatusRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  AddStatusRemoteDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, AddStatusModel>> addStatus(
  {
    required File status
   }

      ) async {
    if (await networkInfo.hasConnection) {
      try {

        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        String fileName='';

          fileName = status.path.split('/').last;


        FormData formData = FormData.fromMap({
            "status":
            await MultipartFile.fromFile(status.path, filename:fileName),

        });
        final re = await dio.post
          (
          Endpoints.addStatus,
          data: formData,
        );
        if(re.statusCode!>=200&&re.statusCode!<300)
          {
            return Right(AddStatusModel.fromJson(json.decode(re.data)));
          }
        else{
          return Left(Er.error);
        }


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
      return Left(Er.error);
    }
  }


}
