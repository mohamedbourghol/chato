import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../../Globals.dart';
import '../model/profile/profile_model.dart';



abstract class ProfileDetailsRemoteDataSource {
  Future<Either<String, ProfileModel>> profileDetails();

}

class ProfileDetailsRemoteDataSourceImpl extends ProfileDetailsRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  ProfileDetailsRemoteDataSourceImpl(
      { required this.dio, required this.networkInfo});

  @override
  Future<Either<String, ProfileModel>> profileDetails() async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] = "Bearer ${Global.userToken}";
        final re = await dio.get
          (Endpoints.profileDetails,
          queryParameters: {
          },

        );

        print(re);
        ProfileModel profile=ProfileModel.fromJson(json.decode(re.data));
        print("re");
        print(profile.data);
        print("re");
        return Right(ProfileModel.fromJson(json.decode(re.data)));
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
