import 'dart:convert';
import 'package:chato/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import '../../../../Globals.dart';
import '../model/search_friend/search_friend_model.dart';



abstract class SearchFriendRemoteDataSource {
  Future<Either<String, SearchFriendModel>>
      searchFriend({required String search});
 }

class SearchFriendRemoteDataSourceImpl extends
   SearchFriendRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  SearchFriendRemoteDataSourceImpl(
      { required this.dio,
        required this.networkInfo
      });

  @override
  Future<Either<String, SearchFriendModel>>
      searchFriend({required String search}) async {
    if (await networkInfo.hasConnection) {
      try {
        dio.options.headers["Authorization"] =
        "Bearer ${Global.userToken}";
        final re = await dio.get
          (
          Endpoints.searchFriend,
          queryParameters: {
            "search":search
          },

        );
        return Right(SearchFriendModel.fromJson(json.decode(re.data)));
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
