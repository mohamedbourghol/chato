
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chato/Globals.dart';
import 'package:chato/feature/Pages/HomePage/api/add_status_remote.dart';
import '../api/all_friend_remote.dart';
import '../api/change-requests-friend_remote.dart';
import '../api/friendship_requests_remote.dart';
import '../api/get_status_remote.dart';
import '../api/search-friend_remote.dart';
import '../api/seen_status_remote.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FriendshipRequestsRemoteDataSource friendshipRequestsRemoteDataSource;
  ChangeRequestsFriendRemoteDataSource changeRequestsFriendRemoteDataSource;
  SearchFriendRemoteDataSource searchFriendRemoteDataSource;
  AllFriendRemoteDataSource allFriendRemoteDataSource;
  AddStatusRemoteDataSource addStatusRemoteDataSource;
  GetStatusRemoteDataSource getStatusRemoteDataSource;
  SeenStatusRemoteDataSource seenStatusRemoteDataSource;

  HomeBloc({
    required this.friendshipRequestsRemoteDataSource,
    required this.changeRequestsFriendRemoteDataSource,
    required this.searchFriendRemoteDataSource,
    required this.allFriendRemoteDataSource,
    required this.addStatusRemoteDataSource,
    required this.getStatusRemoteDataSource,
    required this.seenStatusRemoteDataSource
    }) : super(HomeState.initial())


  {
    on<ChangePageEvent>((event, emit) =>
        emit(state.rebuild((b) => b
      ..selectedPage=event.pageNumber
     )
    ));






    ///FriendshipRequests
    on<GetFriendshipRequestsEvent>((event, emit)
    async {
      emit(state.rebuild((b) => b
        ..isLoading=true
       ..isSuccess=false
          ..error=''

      ));
      final result=await
      friendshipRequestsRemoteDataSource.friendshipRequests();
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccess = false
          ..isLoading = false
          ..error = l));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..isSuccess = true
          ..isLoading = false
          ..error=''
          ..friendshipRequestsModel = r
        ));
      });
    });


    ///addStatusFriend
    on<AddStatusEvent>((event, emit)
    async {
      emit(state.rebuild((b) => b
        ..error=''
      ));
      final result=await
      addStatusRemoteDataSource.addStatus(status: event.file);
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b

          ..error = l));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..addStatusModel = r
        ));
      });
    });



    ///كل الاصدقاء
    on<GetAllFriendEvent>((event, emit)
    async {
      emit(state.rebuild((b) => b
        ..error=''
          ..isLoadingGetAllFriend=true
          ..isSuccessGetAllFriend=false

      ));
      final result=await
      allFriendRemoteDataSource.allFriend();
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..error = l));
        emit(state.rebuild((b) => b
          ..isLoadingGetAllFriend=false
          ..isSuccessGetAllFriend=false
          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoadingGetAllFriend=false
          ..isSuccessGetAllFriend=true
          ..allFriendModel = r
        ));
      });
    });








    ///قبول رفض طلبات الصداقة
    on<ChangeRequestsFriend>((event, emit)
    async {

      emit(state.rebuild((b) => b
        ..error=''

      ));
      final result=await changeRequestsFriendRemoteDataSource.
      changeRequestsFriend(
          id: event.id,
          status: event.status);
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b

          ..error = l));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ));
      });
    });



    ///بحث عن صديق
    on<GetSearchFriendEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
          ..error=''
          ..isLoadingSearch=true
          ..isSuccessSearch=false

      ));
      final result=await searchFriendRemoteDataSource.
      searchFriend(
          search: event.search
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoadingSearch=false
          ..isSuccessSearch=false
          ..error = l
        ));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoadingSearch=false
          ..isSuccessSearch=true
            ..searchFriendModel=r
        ));
      });
    });


    ///seenStatus
    on<SeenStatusEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''


          ));
      final result=await seenStatusRemoteDataSource.
      seenStatus(
          statusId: event.statusId
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b

          ..error = l
        ));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        List<int> seen=[];
        for(var item in state.seenStatus)
          {
            seen.add(item);
          }
        seen[event.index]=event.seenNumber;
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
            ..seenStatus=seen

        ));
      });
    });


    /// status
    on<GetStatusEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..isLoading=true
            ..isSuccess=false

          ));
      final result=await getStatusRemoteDataSource.
      getStatus();

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoading=false
          ..isSuccess=false
          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..error = ''));
      }, (r) async {
        List<int> seen=[];
        int se=0;
        if(r.data!=null)
          {

            for(int i=0;i<r.data!.length;i++)
            {        if(r.data![i].id==Global.userId)
              {
                Global.myStatus=r.data![i].status_users;
              }
              se=0;
              for(var item in r.data![i].status_users!)
                {

                  if(item.seen=='1')
                    {
                      se++;
                    }
                }
              seen.add(se);

            }
          }

        emit(state.rebuild((b) => b
          ..error=''
          ..seenStatus=seen
          ..isLoading=false
          ..isSuccess=true
          ..getStatusModel=r
        ));

      });
    });


  }

  void onChangePageEvent(int pageNumber) {
    add(ChangePageEvent(pageNumber));
  }
  void onGetFriendshipRequestsEvent() {
    add(GetFriendshipRequestsEvent());
  }
  void onGetAllFriendEvent() {
    add(GetAllFriendEvent());
  }

  void onGetSearchFriendEvent(String search) {
    add(GetSearchFriendEvent(search: search));
  }

  void onChangeRequestsFriend(  {
    required int id, required String status}) {
    add(ChangeRequestsFriend( status: status,id: id));
  }


  void onAddStatusEvent(  {
    required File status}) {
    add(AddStatusEvent(  file: status));
  }
  void onSeenStatusEvent(  {
    required int statusId,
    required int index,
    required int seenNumber
  }) {
    add(SeenStatusEvent(statusId: statusId,
    index: index,
      seenNumber: seenNumber
    ));
  }

  void onGetStatusEvent( ) {
    add(GetStatusEvent( ));
  }


}