
import 'package:built_value/built_value.dart';

import '../model/allModel/all_room_model.dart';
import '../model/create_room_model.dart';
import '../model/favModel/fav_room_model.dart';
import '../model/trendModel/trend_room_model.dart';
import '../model/userRooms/user_room_model.dart';
part 'room_state.g.dart';


abstract class RoomState implements Built<RoomState, RoomStateBuilder> {


  bool? get isSuccess;
  bool? get isLoading;
  String get error;

  bool? get isSuccessGetUserRoom;
  bool? get isLoadingGetUserRoom;
  String get errorGetUserRoom;
  int get selectedFilter;

  bool? get isSuccessGetFavRoom;
  bool? get isLoadingGetFavRoom;
  String get errorGetFavRoom;

  bool? get isSuccessGetTrendRoom;
  bool? get isLoadingGetTrendRoom;
  String get errorGetTrendRoom;

  bool? get isSuccessGetAllRoom;
  bool? get isLoadingGetAllRoom;
  String get errorGetAllRoom;

  CreateRoomModel get createRoomModel;
  UserRoomModel get userRoomModel;
  FavRoomModel get favRoomModel;
  TrendRoomModel get trendRoomModel;
  AllRoomModel get allRoomModel;

  String get search;

  RoomState._();

  factory RoomState([void Function(RoomStateBuilder) updates])
  = _$RoomState;

  factory RoomState.initial() {
    return RoomState((b) => b
      ..isLoading = false
      ..isSuccess = false
        ..error=''
      ..isSuccessGetTrendRoom=false
      ..isLoadingGetTrendRoom=false
      ..errorGetTrendRoom=''
      ..isLoadingGetUserRoom = false
      ..isSuccessGetUserRoom = false
      ..errorGetUserRoom=''
      ..favRoomModel=FavRoomModel(
        data: [],
        message: '',
        status: false,
        error_code: 0
      )
      ..selectedFilter=0
        ..createRoomModel=CreateRoomModel(error_code: 0,
          message: '',
          status: false

        )
        ..userRoomModel=UserRoomModel(
          error_code: 0,
          status: false,
          message: '',
          data: []
        )
      ..isSuccessGetFavRoom=false
      ..isLoadingGetFavRoom=false
        ..errorGetFavRoom=''
        ..trendRoomModel=TrendRoomModel(error_code: 0,
            message: '', status: false, data: [])
        ..allRoomModel=AllRoomModel(message: '',
          error_code: 0,
          status: false,
          data: []
        )
        ..isLoadingGetAllRoom=false
          ..isSuccessGetAllRoom=false
        ..errorGetAllRoom=''
        ..search=''
    );
  }
}


