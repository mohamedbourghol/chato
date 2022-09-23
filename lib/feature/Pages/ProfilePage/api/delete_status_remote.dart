import 'dart:convert';
import 'dart:io';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../../HomePage/model/addStatus/add_status_model.dart';




abstract class DeleteStatusRemoteDataSource {
  Future<Either<String, AddStatusModel>> deleteStatus({
    required int statusId
});
}

class DeleteStatusRemoteDataSourceImpl extends DeleteStatusRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  DeleteStatusRemoteDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, AddStatusModel>> deleteStatus(
  {
    required int statusId
   }
      ) async {
    if (await networkInfo.hasConnection) {
      try {

        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";

        FormData formData = FormData.fromMap({
            "status_id": statusId,
        });
        final re = await dio.post
          (
          Endpoints.deleteStatus,
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
