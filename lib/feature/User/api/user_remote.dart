import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:chato/feature/User/model/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../Globals.dart';


abstract class UserDetailsRemoteDataSource {
  Future<Either<String, UserModel>> userDetails({required int id});

}

class UserDetailsRemoteDataSourceImpl extends UserDetailsRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  UserDetailsRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, UserModel>> userDetails({required int id}) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] = "Bearer ${Global.userToken}";
        final re = await dio.get
          (Endpoints.friendsDetails,
          queryParameters: {
            'id':id
          },

        );

        print(re);
        UserModel user=UserModel.fromJson(json.decode(re.data));
        print("re");
        print(user.data!.user!.id!);
        await dio.post
          (Endpoints.viewerUser,
          data: {
            'friend_id':id
          },

        );
        print("re");
        return Right(UserModel.fromJson(json.decode(re.data)));
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
