import 'package:bloc/bloc.dart';
import 'package:chato/feature/Pages/RoomPage/bloc/room_event.dart';
import 'package:chato/feature/Pages/RoomPage/bloc/room_state.dart';
import 'package:chato/feature/Pages/RoomPage/model/create_room_model.dart';
import 'package:chato/feature/Pages/RoomPage/model/favModel/fav_room_data_model.dart';
import '../../../RoomConversation/api/add_remove_fav_remote.dart';
import '../api/create_room_remote.dart';
import '../api/get_all_room_remote.dart';
import '../api/get_fav_room_remote.dart';
import '../api/get_trend_room_remote.dart';
import '../api/get_user_all_room_remote.dart';
import '../model/allModel/all_room_model.dart';
import '../model/favModel/fav_room_model.dart';
import '../model/trendModel/trend_room_model.dart';
import '../model/userRooms/user_room_model.dart';






class RoomBloc extends Bloc<RoomEvent, RoomState> {
  CreateRoomRemoteDataSource createRoomRemoteDataSource;
  GetUserRoomRemoteDataSource getUserRoomRemoteDataSource;
  GetFavRoomRemoteDataSource getFavRoomRemoteDataSource;
  GetTrendRoomRemoteDataSource getTrendRoomRemoteDataSource;
  GetAllRoomRemoteDataSource getAllRoomRemoteDataSource;
  AddRemoveFavDataSource addRemoveFavDataSource;

  RoomBloc({
    required this.createRoomRemoteDataSource,
    required this.getUserRoomRemoteDataSource,
    required this.getFavRoomRemoteDataSource,
    required this.getTrendRoomRemoteDataSource,
    required this.getAllRoomRemoteDataSource,
    required this.addRemoveFavDataSource
  }) :
        super(RoomState.initial())
  {
    on<ChangeFilterEvent>((event, emit) =>
        emit(state.rebuild((b) => b
          ..selectedFilter=event.selectFilter
         )
        ));




    //get fav room
    on<GetFavRoomEvent>((event, emit) async {
      emit(state.rebuild((b) => b

        ..isLoadingGetFavRoom = true
        ..errorGetFavRoom=''
        ..isSuccessGetFavRoom = false
        ..favRoomModel=FavRoomModel(
              error_code: 0,
              message: '',
              status: null,
            data: []
          )

      ));

      final result = await
      getFavRoomRemoteDataSource.getFavRoom();

      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..errorGetFavRoom = l
          ..isLoadingGetFavRoom = false
          ..isSuccessGetFavRoom = false
        ));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..errorGetFavRoom=''
          ..isSuccessGetFavRoom = true
          ..isLoadingGetFavRoom = false
          ..favRoomModel=r
        ));
      });
    });


    //get user room
    on<GetUserRoomEvent>((event, emit) async {
      emit(state.rebuild((b) => b

        ..isLoadingGetUserRoom = true
        ..errorGetUserRoom=''
        ..isSuccessGetUserRoom = false
        ..userRoomModel=UserRoomModel(
            error_code: 0,
            message: '',
            status: null,
            data: []
        )

      ));

      final result = await
      getUserRoomRemoteDataSource.getUserRoom(

      );

      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..errorGetUserRoom = l
          ..isLoadingGetUserRoom = false
          ..isSuccessGetUserRoom = false
        ));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..errorGetUserRoom=''
          ..isLoadingGetUserRoom = false
          ..isSuccessGetUserRoom = true
          ..userRoomModel=r
        ));
      });
    });



    //get trend room
    on<GetTrendRoomEvent>((event, emit) async {
      emit(state.rebuild((b) => b

        ..isLoadingGetTrendRoom = true
        ..errorGetTrendRoom=''
        ..isSuccessGetTrendRoom = false
        ..trendRoomModel=TrendRoomModel(
            error_code: 0,
            message: '',
            status: null,
            data: []
        )

      ));

      final result = await
      getTrendRoomRemoteDataSource.getTrendRoom(

      );

      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..errorGetTrendRoom = l
          ..isLoadingGetTrendRoom = false
          ..isSuccessGetTrendRoom = false
        ));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..errorGetTrendRoom=''
          ..isLoadingGetTrendRoom = false
          ..isSuccessGetTrendRoom = true
          ..trendRoomModel=r
        ));
      });
    });


    //get all room
    on<GetAllRoomEvent>((event, emit) async {
      emit(state.rebuild((b) => b

        ..isLoadingGetAllRoom = true
        ..errorGetAllRoom=''
        ..isSuccessGetAllRoom = false
        ..allRoomModel=AllRoomModel(
            error_code: 0,
            message: '',
            status: null,
            data: []
        )

      ));

      final result = await
      getAllRoomRemoteDataSource.getAllRoom(

      );

      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..errorGetAllRoom = l
          ..isLoadingGetAllRoom = false
          ..isSuccessGetAllRoom = false
        ));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..errorGetAllRoom=''
          ..isLoadingGetAllRoom = false
          ..isSuccessGetAllRoom = true
          ..allRoomModel=r
        ));
      });
    });


    //create room
    on<CreateRoomEvent>((event, emit) async {
      emit(state.rebuild((b) => b
        ..isLoading = true
        ..error=''
        ..isSuccess = false
        ..createRoomModel=CreateRoomModel(error_code: 0,
            message: '', status: null)
      ));

      final result = await
      createRoomRemoteDataSource.createRoom(
          name: event.roomName,
        coinsNumber: 1500
      );

      print("result");
      print(result);
      print("result");

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..error = l
          ..isLoading = false
          ..isSuccess = false
        ));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..error=''
          ..isLoading = false
          ..isSuccess = true
          ..createRoomModel=r
        ));
      });
    });


    on<RemoveFavEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''

          ));
      final result=await
      addRemoveFavDataSource.
      addRemoveFavRoom(
          roomId: event.roomId
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b

          ..error = l
        ));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''


        ));


      });
    });

    on<SearchEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..search=event.se

          ));

    });


  }


  void onChangeFilter(int filter) {
    add(ChangeFilterEvent(filter));
  }

  void onCreateRoomEvent(String roomName) {
    add(CreateRoomEvent(roomName: roomName));
  }

  void onGetUserRoomEvent() {
    add(GetUserRoomEvent());
  }

  void onGetFavRoomEvent() {
    add(GetFavRoomEvent());
  }

  void onGetTrendRoomEvent() {
    add(GetTrendRoomEvent());
  }

  void onGetAllRoomEvent() {
    add(GetAllRoomEvent());
  }
  void onRemoveFavEvent(int roomId) {
    add(RemoveFavEvent(roomId: roomId));
  }
  void onSearchEvent(String se) {
    add(SearchEvent(se: se));
  }

}