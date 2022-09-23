
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chato/Globals.dart';
import 'package:chato/feature/RoomConversation/api/get_blocked_remote.dart';
import 'package:chato/feature/RoomConversation/api/get_user_permeation_remote.dart';
import 'package:chato/feature/RoomConversation/api/unblock_user_room_remote.dart';
import 'package:chato/feature/RoomConversation/model/sendGiftRoom/send_gift_model.dart';
import 'package:chato/feature/User/model/user_data.dart';
import 'package:profanity_filter/profanity_filter.dart';
import '../../../core/utils/int_to_time.dart';
import '../../../injection.dart';
import '../../Conversation/model/bloc_user_model.dart';
import '../api/add_remove_fav_remote.dart';
import '../api/add_trend_room_remote.dart';
import '../api/add_user_remote.dart';
import '../api/block_user_room_remote.dart';
import '../api/change-permeation-user-room_remote.dart';
import '../api/delete_user_room_remote.dart';
import '../api/get_all_type_message_remote.dart';
import '../api/get_background_image_remote.dart';
import '../api/get_conversation_old_message_remote.dart';
import '../api/get_gift_remote.dart';
import '../api/send_gift_room_remote.dart';
import '../api/send_message_remote.dart';
import '../api/update_room_remote.dart';
import '../model/addTrendRoom/add_trend_model.dart';
import '../model/allType/all_type_data_model.dart';
import '../model/allType/all_type_model.dart';
import '../model/backgroundImageRoom/background_image_data_model.dart';
import '../model/conversationMessage/conversation_old_message_data_model.dart';
import '../model/conversationMessage/conversation_old_message_model.dart';
import '../model/deleteUserRoom/delete_user_model.dart';
import '../model/getGiftRoom/get_gift_data_model.dart';
import 'room_conversation_event.dart';
import 'room_conversation_state.dart';

class RoomConversationBloc
    extends Bloc<RoomConversationEvent,
        RoomConversationState> {
  ConversationOldMessageDataSource conversationOldMessageDataSource;
  AllTypeDataSource allTypeDataSource;
  SendMessageDataSource sendMessageDataSource;
  AddUserDataSource addUserDataSource;
  AddRemoveFavDataSource addRemoveFavDataSource;
  ChangePermeationUserRoomDataSource changePermeationUserRoomDataSource;
  GetBackgroundImageSource getBackgroundImageSource;
  UpdateRoomDataSource updateRoomDataSource;
  GetGiftSource getGiftSource;
  SendGiftRoomDataSource sendGiftRoomDataSource;
  DeleteUserRoomDataSource deleteUserRoomDataSource;
  BlockUserRoomDataSource blockUserRoomDataSource;
  AddTrendDataSource addTrendDataSource;
  BlockedDataSource blockedDataSource;
  UnBlockUserRoomDataSource unBlockUserRoomDataSource;
  UserPermeationDataSource userPermeationDataSource;


  RoomConversationBloc({
    required this.conversationOldMessageDataSource,
    required this.allTypeDataSource,
    required this.sendMessageDataSource,
    required this.addUserDataSource,
    required this.addRemoveFavDataSource,
    required this.changePermeationUserRoomDataSource,
    required this.getBackgroundImageSource,
    required this.updateRoomDataSource,
    required this.getGiftSource,
    required this.sendGiftRoomDataSource,
    required this.deleteUserRoomDataSource,
    required this.blockUserRoomDataSource,
    required this.addTrendDataSource,
    required this.blockedDataSource,
    required this.unBlockUserRoomDataSource,
    required this.userPermeationDataSource
   }) : super(
      RoomConversationState.initial()) {

    on<ShowEmojiEvent>(
        (event, emit) => emit(state.rebuild((b) =>
        b..showEmoji = event.show)));

    on<ChangeRecordTimerEvent>(
            (event, emit) => emit(state.rebuild((b) =>
        b..recordTime = intToTimeLeft(event.count))));

    on<StartRecordEvent>((event, emit) =>
        emit(state.rebuild((b) => b..isRecord =
            event.isRecord)));


    on<ChangeGiftEvent>((event, emit) {
      emit(state.rebuild((b) =>
      b..senGiftType =
          event.type


      ));

    });

    on<EnterVipEvent>((event, emit) {
      emit(state.rebuild((b) =>
      b..name =
          event.name
          ..img=event.img
          ..enable=event.enable


      ));

    });



    on<WantToExitEvent>((event, emit) =>
        emit(state.rebuild((b) => b..wantToExit =
            event.wantExit)));


    on<AddSmileEvent>((event, emit) {
      emit(state.rebuild((b) =>
          b..smile = event.smile));
      emit(state.rebuild((b) =>
         b..smile = ''  ));
    });


    on<AddMessageFromPusherEvent>((event, emit) {
      ConversationOldMessageModel messageModel=
      ConversationOldMessageModel(data: [],
      status: false,
        error_code: 0,
        message: ''
      );
      for(var message in state.conversationOldMessageModel.data!)
        {
          messageModel.data!.add(message);

        }
      messageModel.data!.add(event.message);
      emit(state.rebuild((b) =>
             b..conversationOldMessageModel=
                 messageModel  ));
    });


      on<SwitchSmileStickerEvent>((event, emit) {
        emit(state.rebuild((b) =>
            b..smileOrSticker = event.smile
        ));
      });


    on<ChangeRocketEvent>((event, emit) {
      emit(state.rebuild((b) =>
      b..showRocket = event.showRocket
          ..showRocketUserName=event.userName
          ..xNumber=event.xNumber
      ));
    });

    on<AddGiftEvent>((event, emit) {
      emit(state.rebuild((b) =>
      b..showGift = event.showGift
        ..txtGift=event.txtGift
        ..imgGift=event.imgGift
        ..showGiftCenter=event.showGiftCenter
      ));
    });



      on<GetConversationMessage>((event, emit)
      async {
        emit(
            state.rebuild((b) => b
              ..error=''
              ..isLoading=true
              ..isSuccess=false
               ..primaryBackground=BackgroundImageDataModel(
                id: 1,
                background:''

            )
     ..conversationOldMessageModel=
         ConversationOldMessageModel(
           message: '',
           error_code: 0,
           status: false,
           data: []
         )
            ));
        final result=await
        conversationOldMessageDataSource.
        getConversationOldMessage(
          conversationId: event.id
        );
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
          print('r');
          ConversationOldMessageModel data=
          ConversationOldMessageModel(
              status: false,
          message: '',
            error_code: 0,
            data: []
          );
          for(int i=0;i<r.data!.length;i++){
            data.data!.add(r.data![r.data!.length-i-1]);
          }
          emit(state.rebuild((b) => b
            ..error=''
            ..isLoading=false
            ..conversationOldMessageModel=data
            ..isSuccess=true
          ));
        });
      });


    on<GetAllTypeEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
              ..isLoadingAllType=true
            ..isSuccessAllType=false
          ));
      final result=await
      allTypeDataSource.
      getAllType(
          type: event.type,
        roomId: event.roomId
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoadingAllType=false
          ..isSuccessAllType=false
          ..error = l
        ));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        print('r');
         if(event.type=='user')
           {
             emit(state.rebuild((b) => b
               ..error=''
               ..isLoadingAllType=false
               ..isSuccessAllType=true
               ..allTypeUser=r
             ));
           }
         else if(event.type=='owner'){
           emit(state.rebuild((b) => b
             ..error=''
             ..isLoadingAllType=false
             ..isSuccessAllType=true
             ..allTypeOwner=r
           ));
         }
         else if(event.type=='admin') {
           emit(state.rebuild((b) => b
             ..error=''
             ..isLoadingAllType=false
             ..isSuccessAllType=true
             ..allTypeAdmin=r
           ));
         }
         else  {

           if(r.data!=null)
             {
               bool exist=false;
               for(var item in r.data!)
               {
                 if(item.id==Global.userId)
                 {
                   exist=true;
                   break;
                 }
               }
               if(!exist)
               {
                 addUserDataSource.
                 addUser(
                     userId: Global.userId!,
                     roomId: event.roomId
                 );
                 emit(state.rebuild((b) => b
                   ..error=''
                   ..isLoadingAllType=false
                   ..isSuccessAllType=true
                   ..allTypeModel=r
                 ));

               }
               else{
                 emit(state.rebuild((b) => b
                   ..error=''
                   ..isLoadingAllType=false
                   ..isSuccessAllType=false
                   ..allTypeModel=r
                 ));
               }

             }
           else{
             addUserDataSource.
             addUser(
                 userId: Global.userId!,
                 roomId: event.roomId
             );
             emit(state.rebuild((b) => b
               ..error=''
               ..isLoadingAllType=false
               ..isSuccessAllType=true
               ..allTypeModel=r
             ));

           }




         }

      });
    });



    //sendMessage
    on<SendMessageEvent>((event, emit)
    async {
      final filter =sl<ProfanityFilter> ();


      String cleanString = filter.censor(event.message);

      emit(
          state.rebuild((b) => b
            ..error=''
              ..conversationOldMessageModel!.data!.add(
                  ConversationOldMessageDataModel(
                    id: 0,
                    message: cleanString,
                    localFile: event.allFile!=null?event.allFile!.path:
                      '',
                    conversation_id: '0',
                    seen: '',
                    created_at: '',
                    updated_at: '',
                    user: UserData(
                      id: Global.userId,
                      name: Global.userName,
                      email: '',
                      img: Global.userImage,
                      token: Global.userToken,
                      birth_date: '',
                      gender: ''
                    )
                  )
              )
          ));
      if(event.api) {
        final result=await
      sendMessageDataSource.
      sendMessage(
          message: cleanString,
          roomId: event.roomId,
        file: event.allFile
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

            ..sendMessageModel=r
          ));


        });
      }

    });


    on<ChangePermeationUserEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
              ..isSuccessChangePer=false
              ..isLoadingChangePer=true

          ));
      final result=await
      changePermeationUserRoomDataSource.
      changePermeationUser(
          userId: event.userId,
          roomId: event.roomId,
             type: event.type

      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccessChangePer=false
          ..isLoadingChangePer=false
          ..error = l
        ));
        emit(state.rebuild((b) => b

          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isSuccessChangePer=true
          ..isLoadingChangePer=false
          ..changePermeationModel=r

        ));

        emit(state.rebuild((b) => b
          ..isSuccessChangePer=false
        ));


      });
    });


   //AddUserRoomEvent
    on<AddUserRoomEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''

          ));
      final result=await
      addUserDataSource.
      addUser(
          userId: event.user_id,
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


    //GetBackgroundImageEvent
    on<GetBackgroundImageEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
              ..isLoadingGetBackgroundImage=true

          ));
      final result=await
      getBackgroundImageSource.
      getBackgroundImage(
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
         ..isLoadingGetBackgroundImage=false
          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..isLoadingGetBackgroundImage=false
          ..error = ''));
      }, (r) async {
        print('r');

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoadingGetBackgroundImage=false
            ..backgroundImageModel=r

        ));


      });
    });


    //GetBackgroundImageEvent
    on<GetBlockedEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''


          ));
      final result=await
      blockedDataSource.
       getBlocked(roomId: event.roomId
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

          ..allTypeBlock=r

        ));


      });
    });


    //GetGiftEvent
    on<GetGiftEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..isSuccessGetGift=false
            ..isLoadingGetGift=true
          ));

      final result=await
      getGiftSource.getGift();

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isSuccessGetGift=false
          ..isLoadingGetGift=false

          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..isLoadingGetBackgroundImage=false
          ..error = ''));
      }, (r) async {
        print('r');
        List<GetGiftDataModel>  gifts=[];
        List<GetGiftDataModel>  flags=[];
        List<GetGiftDataModel>  vip=[];
        List<GetGiftDataModel>  featured=[];
        List<GetGiftDataModel>  rich=[];

          for(var gif in r.data!)
            {
              if(gif.category=='gifts')
                {
                  gifts.add(gif);
                }
              else if(gif.category=='Flags')
              {
                flags.add(gif);
              }
              else if(gif.category=='Vip')
              {
                vip.add(gif);
              }
              else if(gif.category=='Featured')
              {
                featured.add(gif);
              }
              else if(gif.category=='rich')
              {
                rich.add(gif);
              }
            }
        emit(state.rebuild((b) => b
          ..error=''
          ..isSuccessGetGift=true
          ..isLoadingGetGift=false
          ..getGiftModel=r
            ..rich=rich
            ..featured=featured
            ..gifts=gifts
            ..flags=flags
            ..vip=vip
        ));


      });
    });


    on<AddRemoveFavRoomEvent>((event, emit)
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


    on<SendGiftEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
              ..isLoadingGetGift=true
              ..isSuccessGetGift=true
          ));
      final result=await
      sendGiftRoomDataSource.
      sendGift(
          userId: event.userId,
         roomId: event.roomId,
        giftId: event.giftId
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoadingGetGift=false
          ..isSuccessGetGift=false
          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..error=''
        ));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..isLoadingGetGift=false
          ..isSuccessGetGift=true
          ..error = ''
          ..sendGiftModel=r
        ));

        emit(state.rebuild((b) => b
          ..sendGiftModel=SendGiftModel(
              error_code: 0,
              message: '',
              status: false)
        ));



      });
    });


    on<DeleteUserEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..isLoadingChangePer=true
            ..isSuccessChangePer=true

          ));
      final result=await
      deleteUserRoomDataSource.
      deleteUser(
          userId: event.userId,
          roomId: event.roomId,
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoadingChangePer=false
          ..isSuccessChangePer=false
          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..error=''
        ));
      }, (r) async {

        AllTypeModel  allTypeUser=AllTypeModel(status: false,message: '',error_code: 0,data: []);
        AllTypeModel  allTypeModel=AllTypeModel(status: false,message: '',error_code: 0,data: []);
        AllTypeModel  allTypeOwner=AllTypeModel(status: false,message: '',error_code: 0,data: []);
        AllTypeModel  allTypeAdmin=AllTypeModel(status: false,message: '',error_code: 0,data: []);

        if(state.allTypeModel.data!=null)
          {
            for(var al in state.allTypeModel.data!)
            {
              if(al.id!=event.userId)
              {
                allTypeModel.data!.add(al);
              }
            }
          }

        if(state.allTypeUser.data!=null)
          {
            for(var al in state.allTypeUser.data!)
            {
              if(al.id!=event.userId)
              {
                allTypeUser.data!.add(al);
              }
            }
          }

        if(state.allTypeAdmin.data!=null)
          {
            for(var al in state.allTypeAdmin.data!)
            {
              if(al.id!=event.userId)
              {
                allTypeAdmin.data!.add(al);
              }
            }
          }
        if(state.allTypeOwner.data!=null)
          {
            for(var al in state.allTypeOwner.data!)
            {
              if(al.id!=event.userId)
              {
                allTypeOwner.data!.add(al);
              }
            }
          }



        print('r');
        print(event.userId);
        emit(state.rebuild((b) => b
          ..isLoadingChangePer=false
          ..isSuccessChangePer=true
          ..error = ''
          ..deleteUserModel=r
            ..allTypeModel=allTypeModel
            ..allTypeUser=allTypeUser
            ..allTypeOwner=allTypeOwner
            ..allTypeAdmin=allTypeAdmin
        ));
        emit(state.rebuild((b) => b

          ..deleteUserModel=DeleteUserModel(error_code: 0,message: '',status: false)

        ));





      });
    });


    on<BlockUserEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..isLoadingChangePer=true
            ..isSuccessChangePer=true

          ));
      final result=await
      blockUserRoomDataSource.
      blockUser(
        userId: event.userId,
        roomId: event.roomId,
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoadingChangePer=false
          ..isSuccessChangePer=false
          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..error=''
        ));
      }, (r) async {

        print('r');
        print(event.userId);
        emit(state.rebuild((b) => b
          ..isLoadingChangePer=false
          ..isSuccessChangePer=true
          ..error = ''
          ..blockUserModel=r
        ));
        emit(state.rebuild((b) => b

          ..blockUserModel=BlockUserModel(error_code: 0,message: '',status: false)

        ));
      });
    });

    on<UnBlockUserEvent>((event, emit)
    async {
    emit(
    state.rebuild((b) => b
    ..error=''
    ..isLoadingChangePer=true
    ..isSuccessChangePer=true

    ));
    final result=await
    unBlockUserRoomDataSource.
    unblockUser(
    userId: event.userId,
    roomId: event.roomId,
    );
    return result.fold((l) async {
    print('l');
    emit(state.rebuild((b) => b
    ..isLoadingChangePer=false
    ..isSuccessChangePer=false
    ..error = l
    ));
    emit(state.rebuild((b) => b
    ..error=''
    ));
    }, (r) async {

    print('r');
    print(event.userId);
    emit(state.rebuild((b) => b
    ..isLoadingChangePer=false
    ..isSuccessChangePer=true
    ..error = ''
    ..blockUserModel=r
    ));
    emit(state.rebuild((b) => b

    ..blockUserModel=
    BlockUserModel(error_code: 0,message: '',status: false)

    ));
    });
    });

    on<AddTrendEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..isLoadingChangePer=true
            ..isSuccessChangePer=true

          ));
      final result=await
      addTrendDataSource.
      addTrendRoom(
        payment: event.payment,
        roomId: event.roomId,
        count: event.count
      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoadingChangePer=false
          ..isSuccessChangePer=false
          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..error=''
        ));
      }, (r) async {
         Global.userCoins=(double.tryParse(Global.userCoins!)!-double.tryParse(event.payment)!).toString();
        print('r');

        emit(state.rebuild((b) => b
          ..isLoadingChangePer=false
          ..isSuccessChangePer=true
          ..error = ''
          ..addTrendModel=r
        ));
        emit(state.rebuild((b) => b
          ..addTrendModel=AddTrendModel(error_code: 0,message: '',status: false)
        ));
      });
    });

    on<ChangeBackgroundImageEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
              ..primaryBackground=BackgroundImageDataModel(
                id: event.id??1,
                background: event.backgroundImage

              )
          ));

      if(event.id!=null)
        {final result=await
          updateRoomDataSource.updateRoom
            (backId: event.id!, roomId: event.roomId!,
          image: null

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
        }

    });

    on<ChangeRoomImageEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..roomImage=event.image
          ));

        final result=await
      updateRoomDataSource.updateRoom
        (backId: null,
          roomId: event.roomId!,
          image: event.image

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


    on<GetPermeationEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..conversationOldMessageModel=
            ConversationOldMessageModel(
                data: [],
                status:false,
                error_code: 0,
                message: ''
            )
            ..userPermission='user'
          ));

      final result=await
      userPermeationDataSource.getUserPermeation
        (
          roomId: event.roomId,

      );
      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..userPermission='user'
        ));
      }, (r) async {
        print('r');
        emit(state.rebuild((b) => b
          ..userPermission=r
        ));
      });
    });


  }

  void onShowEmojiEvent(bool show) {
    add(ShowEmojiEvent(show));
  }

  void onStartRecord(bool show) {
    add(StartRecordEvent(show));
  }

  void onChangeGiftEvent(int type) {
    add(ChangeGiftEvent(type));
  }

  void onAddSmileEvent(String smile) {
    add(AddSmileEvent(smile: smile));
  }

  void onSwitchSmileStickerEvent(bool smile) {
    add(SwitchSmileStickerEvent(smile: smile));
  }

  void onGetConversationMessage(int id) {
    add(GetConversationMessage(id: id));
  }
  void onGetAllTypeEvent(String type,int roomId) {
    add(GetAllTypeEvent(type: type,roomId: roomId));
  }

  void onSendMessageEvent(String message,int roomId,
      File? file,bool api) {
    add(SendMessageEvent(message: message,roomId: roomId,
        allFile: file,
      api: api
    ));
  }

  void onAddUserRoomEvent(int userId,int roomId) {
    add(AddUserRoomEvent(user_id: userId,roomId: roomId));
  }
    void onAddMessageFromPusherEvent(
        ConversationOldMessageDataModel message) {
      add(AddMessageFromPusherEvent(message: message));
    }

  void onChangeRecordTimerEvent(
      int counter) {
    add(ChangeRecordTimerEvent(count: counter));
  }


  void onAddRemoveFavRoomEvent(
      int roomId) {
    add(AddRemoveFavRoomEvent(roomId: roomId));
  }

  void onWantToExitEvent(
      bool wantToExit) {
    add(WantToExitEvent(wantExit: wantToExit));
  }

  void onChangePermeationUserEvent(
      int roomId,
      int userId,
      String type) {
    add(ChangePermeationUserEvent(
        roomId: roomId,
        type: type,
        userId:userId
    ));
  }

  void onGetBackgroundImageEvent(
      ) {
    add(GetBackgroundImageEvent(

    ));
  }

  void onGetGiftEvent() {
    add(GetGiftEvent(
    ));
  }

  void onGetBlockedEvent(int roomId) {
    add(GetBlockedEvent(
      roomId: roomId
    ));
  }


  void onChangeBackgroundImageEvent(
      int? id,
      String? backgroundImage,
      int roomId
      ) {
      add(ChangeBackgroundImageEvent(
          backgroundImage: backgroundImage,
        id: id,
        roomId: roomId
    ));
  }

  void onSendGiftEvent(
      int userId,
      int roomId,
      int giftId,
      ) {
    add(SendGiftEvent(
       giftId: giftId,
      roomId: roomId,
      userId: userId

    ));
  }
  void onDeleteUserEvent(
      int userId,
      int roomId,

      ) {
    add(DeleteUserEvent(

        roomId: roomId,
        userId: userId

    ));
  }
  void onBlockUserEvent(
      int userId,
      int roomId,

      ) {
    add(BlockUserEvent(

        roomId: roomId,
        userId: userId

    ));
  }

  void onUnBlockUserEvent(
      int userId,
      int roomId,

      ) {
    add(UnBlockUserEvent(
        roomId: roomId,
        userId: userId

    ));
  }


  void onAddTrendEvent(
  {
   required String payment,
    required  int roomId,
    required  int count
}

      ) {
    add(AddTrendEvent(

        payment: payment,
        roomId: roomId,
      count: count

    ));
  }

  void onChangeRocketEvent(
      bool showRocket,
      String userName,
      int xNumber

      ) {
    add(ChangeRocketEvent(
        showRocket: showRocket,
        userName: userName,
      xNumber: xNumber

    ));

  }

  void onEnterVipEvent(
      String name,
      String? img,
      bool enable
      ) {
    add(EnterVipEvent(
        name: name,
        img: img,
        enable: enable
    ));}

  void onChangeRoomImageEvent(
      File img,
      int roomId
      ) {
    add(ChangeRoomImageEvent(
        roomId: roomId,
      image: img
    ));}

  void onAddGiftEvent(
      bool showGift,
      String txtGift,
      String imgGift,
      bool showGiftCenter,
      ) {
    add(AddGiftEvent(
        imgGift: imgGift,
        showGift: showGift,
        txtGift: txtGift,
        showGiftCenter:showGiftCenter
    ));}

  void onGetPermeationEvent(
      int roomId,
      ) {
    add(GetPermeationEvent(
          roomId: roomId,
    ));}



}
