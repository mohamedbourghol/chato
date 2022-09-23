import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chato/feature/Conversation/model/get_conversation_id_model.dart';
import 'package:profanity_filter/profanity_filter.dart';
import '../../../Globals.dart';
import '../../../core/utils/int_to_time.dart';
import '../../../injection.dart';
import '../../User/model/user_data.dart';
import '../api/block_user_remote.dart';
import '../api/get_conversation_id_remote.dart';
import '../api/get_conversation_old_message_remote.dart';
import '../api/private_send_message_remote.dart';
import '../model/private_old_message_data_model.dart';
import '../model/private_old_message_model.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';


class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  PrivateOldMessageDataSource privateOldMessageDataSource;
  PrivateSendMessageDataSource sendMessageDataSource;
  BlockUserRemoteDataSource blockUserRemoteDataSource;
  GetConversationIdDataSource getConversationIdDataSource;
  ConversationBloc({
    required this.privateOldMessageDataSource,
    required this.sendMessageDataSource,
    required this.blockUserRemoteDataSource,
    required this.getConversationIdDataSource
     }) : super(ConversationState.initial())
  {
    on<ShowEmojiEvent>((event, emit) =>
        emit(state.rebuild((b) => b
      ..showEmoji=event.show
     )
    ));

    on<StartRecordEvent>((event, emit) =>
        emit(state.rebuild((b) => b
          ..isRecord=event.isRecord
        )
        ));

    on<ChangeRecordTimerEvent>(
            (event, emit) => emit(state.rebuild((b) =>
        b..recordTime = intToTimeLeft(event.count))));



    on<GetConversationMessage>((event, emit)
    async {

      if(state.privateOldMessageModel.next_page_url!=null||
          event.page==1)
        {
          emit(
              state.rebuild((b) => b
                ..error=''
                ..isLoading=true
                ..isSuccess=false
                ..getConversationIdModel=GetConversationIdModel(
                    status: false,
                    data: [],
                    message: '',
                    error_code: 0
                )
              ));
          if(event.page==1)
          {
            emit(state.rebuild((b) => b
              ..isSuccess=true
              ..privateOldMessageModel=PrivateOldMessageModel(
                  status: false,
                  message: '',
                  error_code: 0,
                  data: [],
                  next_page_url: null,
              )
            ));
          }

          final result=await
          privateOldMessageDataSource.
          getConversationOldMessage(
              conversationId: event.id,
            page: event.page
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
            PrivateOldMessageModel data=
            PrivateOldMessageModel(status: false,
                message: '',
                error_code: 0,
                data: [],
                next_page_url: r.next_page_url
            );
            for(int i=0;i<r.data!.length;i++){
              data.data!.add(r.data![r.data!.length-i-1]);
            }
            for(int i=0;i<state.privateOldMessageModel.data!.length;i++){
              data.data!.add(state.privateOldMessageModel.data![i]);
            }

            if(event.page==1)
              {
                emit(state.rebuild((b) => b


                  ..isSuccess=true
                ));
              }

            emit(state.rebuild((b) => b
              ..error=''
              ..isLoading=false
              ..privateOldMessageModel=data
            ));
          });
        }

    });


    on<BlockUserEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..isLoadingBloc=true
            ..isSuccessBloc=false
            ..blocUser=''
          ));
      final result=await
      blockUserRemoteDataSource.blockUser(
        blockedId: event.userId
      );

      return result.fold((l) async {
        print('l');
        emit(state.rebuild((b) => b
          ..isLoadingBloc=false
          ..isSuccessBloc=false
          ..error = l
        ));
        emit(state.rebuild((b) => b
          ..error = ''));
      }, (r) async {

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoadingBloc=false
          ..blocUser=r
          ..isSuccessBloc=true
        ));
        emit(state.rebuild((b) => b

          ..blocUser=''
          ..isSuccessBloc=false
        ));
      });
    });


    on<GetConversationIdEvent>((event, emit)
    async {
      emit(
          state.rebuild((b) => b
            ..error=''
            ..isLoading=true
            ..isSuccess=false
            ..privateOldMessageModel=
            PrivateOldMessageModel(
                status: false,
                message: '',
                error_code: 0,
                data: [],
                next_page_url: null
            )
            ..blocUser=''
          ));
      final result=await
      getConversationIdDataSource.getConversationId(
          userId: event.userId
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

        emit(state.rebuild((b) => b
          ..error=''
          ..isLoading=false
          ..getConversationIdModel=r
          ..isSuccess=true
        ));
      });
    });


    on<AddMessageFromPusherEvent>((event, emit) {
      PrivateOldMessageModel messageModel=
      PrivateOldMessageModel(data: [],
          status: false,
          error_code: 0,
          message: '',
        next_page_url: state.privateOldMessageModel.next_page_url
      );
      for(var message in state.privateOldMessageModel.data!)
      {
        messageModel.data!.add(message);

      }
      messageModel.data!.add(event.message);
      emit(state.rebuild((b) =>
      b..privateOldMessageModel=
          messageModel  ));
    });


    on<SendMessageEvent>((event, emit)
    async {
      final filter =sl<ProfanityFilter> ();

      String cleanString = filter.censor(event.message);

      emit(
          state.rebuild((b) => b
            ..error=''
            ..privateOldMessageModel!.data!.add(
                PrivateOldMessageDataModel(
                    id: 0,
                    message: cleanString,
                    localFile: event.allFile!=null?event.allFile!.path:
                    '',
                    conversation_id: '0',
                    seen: '',
                    created_at: '',
                    updated_at: '',
                    all_file: null,
                    user: UserData(
                        id: Global.userId,
                        name: Global.userName,
                        email: '',
                        img: Global.userImage,
                        token: Global.userToken,
                        birth_date: '',
                        gender: ''
                    ),
                )
            )
          ));
      final result=await
      sendMessageDataSource.
      sendMessage(
          message: cleanString,
          userTwoId: event.userTwoId,
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
    });



  }


  void onShowEmojiEvent(bool show) {
    add(ShowEmojiEvent(show));
  }
  void onStartRecord(bool show) {
    add(StartRecordEvent(show));
  }
  void onGetConversationMessage(String id,int page) {
    add(GetConversationMessage( id: id,page: page));
  }
  void onAddMessageFromPusherEvent(PrivateOldMessageDataModel message) {
    add(AddMessageFromPusherEvent(message:message ));
  }
  void onSendMessageEvent(String message,int userTwoId,
      File? file) {
    add(SendMessageEvent(message: message,userTwoId: userTwoId,
        allFile: file));
  }
  void onChangeRecordTimerEvent(
      int counter) {
    add(ChangeRecordTimerEvent(count: counter));
  }
  void onBlockUserEvent(
      int userId) {
    add(BlockUserEvent(userId:userId ));
  }

  void onGetConversationIdEvent(
      int userId) {
    add(GetConversationIdEvent(userId:userId ));
  }

}