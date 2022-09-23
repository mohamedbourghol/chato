import 'dart:io';

import 'package:built_value/built_value.dart';
import 'package:chato/core/utils/constants.dart';
import 'package:chato/feature/RoomConversation/model/blockedTypeRoom/blocked_type_model.dart';
import '../../Conversation/model/bloc_user_model.dart';
import '../model/addTrendRoom/add_trend_model.dart';
import '../model/allType/all_type_model.dart';
import '../model/backgroundImageRoom/background_image_data_model.dart';
import '../model/backgroundImageRoom/background_image_model.dart';
import '../model/changePermeationUser/change_permeation_user_model.dart';
import '../model/conversationMessage/conversation_old_message_model.dart';
import '../model/deleteUserRoom/delete_user_model.dart';
import '../model/getGiftRoom/get_gift_data_model.dart';
import '../model/getGiftRoom/get_gift_model.dart';
import '../model/sendGiftRoom/send_gift_model.dart';
import '../model/sendMessage/send_message_data_model.dart';
import '../model/sendMessage/send_message_model.dart';


part 'room_conversation_state.g.dart';


abstract class RoomConversationState implements Built<RoomConversationState, RoomConversationStateBuilder> {


  bool? get isSuccess;
  bool? get isLoading;

  bool? get isLoadingGetBackgroundImage;



  bool? get isSuccessAllType;
  bool? get isLoadingAllType;

  bool? get isSuccessGetGift;
  bool? get isLoadingGetGift;

  bool? get isSuccessChangePer;
  bool? get isLoadingChangePer;

  bool get showEmoji;
  bool get showRocket;
  String get showRocketUserName;

  bool get isRecord;
  bool get showGiftCenter;
  bool get smileOrSticker;
  int get senGiftType;
  String get smile;
  String get userPermission;
   String get error;
  ConversationOldMessageModel get conversationOldMessageModel;
  AllTypeModel get allTypeUser;
  AllTypeModel get allTypeModel;
  AllTypeModel get allTypeOwner;
  AllTypeModel get allTypeAdmin;
  BlockedTypeModel get allTypeBlock;
  SendMessageModel get sendMessageModel;
  String get recordTime;
  ChangePermeationModel get changePermeationModel;
  bool get wantToExit;
  BackgroundImageModel get backgroundImageModel;
  BackgroundImageDataModel get primaryBackground;
  GetGiftModel get getGiftModel;
  SendGiftModel get sendGiftModel;
  DeleteUserModel get deleteUserModel;
  BlockUserModel get blockUserModel;
  AddTrendModel get addTrendModel;
  List<GetGiftDataModel> get gifts;
  List<GetGiftDataModel> get flags;
  List<GetGiftDataModel> get vip;
  List<GetGiftDataModel> get featured;
  List<GetGiftDataModel> get rich;
  String get name;
  bool get enable;
  bool get showGift;
  String get imgGift;
  String get txtGift;
  String? get img;
  File? get roomImage;
  int? get xNumber;
  RoomConversationState._();

  factory RoomConversationState([void Function(RoomConversationStateBuilder) updates]) = _$RoomConversationState;

  factory RoomConversationState.initial() {
    return RoomConversationState((b) => b
      ..isLoading = false
      ..isSuccess = false
      ..name=''
      ..imgGift=''
      ..showGift=false
      ..enable=false
      ..txtGift=''
      ..img=''
      ..showGiftCenter=false
      ..xNumber=1
      ..userPermission='user'
      ..primaryBackground=BackgroundImageDataModel(
          id: 1,
        background:''

      )
      ..isLoadingAllType = false
      ..isSuccessAllType = false
      ..isLoadingChangePer=false
      ..isSuccessChangePer=false
      ..gifts=[]
      ..flags=[]
      ..vip=[]
      ..featured=[]
      ..rich=[]
      ..showRocket=false
      ..showRocketUserName=''
      ..isLoadingGetBackgroundImage=false
      ..addTrendModel=AddTrendModel(
          error_code: 0,
          message: '',
          status: false)
        ..showEmoji=false
        ..isRecord=false
        ..senGiftType=0
        ..smileOrSticker=true
        ..smile=''
        ..error=''
      ..recordTime='00:00'
      ..wantToExit=false
      ..backgroundImageModel=BackgroundImageModel(message: '', status: false,error_code: 0,data: [])
      ..changePermeationModel=ChangePermeationModel(
        error_code: 0,
        message: '',
        status: false

      )
      ..sendMessageModel=SendMessageModel(message: '',
          status: null,
        error_code: 0,
        data: SendMessageDataModel(
          conversation_id: -1
        )

      )
        ..conversationOldMessageModel=
        ConversationOldMessageModel(
              data: [],
              status:false,
              error_code: 0,
              message: ''
            )
      ..allTypeBlock=BlockedTypeModel(data: [],
          error_code: 0, message: '', status: false)
        ..allTypeModel=AllTypeModel(data: [],
            error_code: 0, message: '', status: false)
        ..allTypeOwner=AllTypeModel(data: [],
          error_code: 0, message: '', status: false)
        ..allTypeAdmin=AllTypeModel(data: [],
          error_code: 0, message: '', status: false)
         ..allTypeUser=AllTypeModel(data: [],
             error_code: 0, message: '', status: false)

        ..getGiftModel=GetGiftModel(status: false,
         data: [],
          error_code: 0,
          message: ''
        )

        ..isSuccessGetGift=false
        ..isLoadingGetGift=false
        ..sendGiftModel=SendGiftModel(
            error_code: 0,
          message: '',
          status: false
        )
        ..deleteUserModel=DeleteUserModel(error_code: 0, message: '', status: false)
        ..blockUserModel=BlockUserModel(error_code: 0, message: '', status: false)


    );
  }
}


