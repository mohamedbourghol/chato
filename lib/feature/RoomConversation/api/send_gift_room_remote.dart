import 'dart:convert';
import 'dart:io';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/allType/all_type_model.dart';
import '../model/sendGiftRoom/send_gift_model.dart';
import '../model/sendMessage/send_message_model.dart';
import '../model/updateRoom/update_room_model.dart';



abstract class SendGiftRoomDataSource {
  Future<Either<String, SendGiftModel>>
  sendGift({
    required int userId,
    required int roomId,
    required int giftId,


   });
}

class SendGiftRoomDataSourceImpl extends
SendGiftRoomDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  SendGiftRoomDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, SendGiftModel>>
  sendGift({
    required int userId,
    required int roomId,
    required int giftId,
  }) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] ="Bearer ${Global.userToken}";
        final re = await dio.post
          (
          Endpoints.sendGiftRoom,
          data: {
            'userR_id':userId,
            'room_id':roomId,
            'gift_id':giftId,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        return  Right(SendGiftModel.fromJson(json.decode(re.data)));
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
