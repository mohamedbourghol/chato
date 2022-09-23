import 'dart:convert';
import 'dart:io';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/allType/all_type_model.dart';
import '../model/sendMessage/send_message_model.dart';
import '../model/updateRoom/update_room_model.dart';



abstract class UpdateRoomDataSource {
  Future<Either<String, UpdateRoomModel>>
   updateRoom({required int? backId,
    required File? image,
    required int roomId,

   });
}

class UpdateRoomDataSourceImpl extends
UpdateRoomDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  UpdateRoomDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, UpdateRoomModel>>
  updateRoom({
    required int? backId,
    required int roomId,
    required File? image,

  }) async {

    if (await networkInfo.hasConnection) {
      String fileName='';
      if(image!=null) {
        fileName = image.path.split('/').last;
      }
      FormData formData = FormData.fromMap({
        if(image!=null)
          "img":
          await MultipartFile.fromFile(image.path, filename:fileName),
        if(backId!=null)
          'background_id':backId,
        'room_id':roomId

      });
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.updateRoom,
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return  Right(json.decode(re.data));
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
