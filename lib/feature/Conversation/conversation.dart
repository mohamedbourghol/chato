import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/feature/Conversation/bloc/conversation_state.dart';
import 'package:chato/feature/Conversation/widget/show_media_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_utils/keyboard_aware/keyboard_aware.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pusher_client/pusher_client.dart';
import '../../../core/utils/color_manager.dart';
import '../../Globals.dart';
import '../../injection.dart';
import '../User/model/user_data.dart';
import 'bloc/conversation_bloc.dart';
import 'model/private_message_pusher_model.dart';
import 'widget/message/sideOne/file_chat_side_one_widget.dart';
import 'widget/message/sideOne/image_side_one_widget.dart';
import 'widget/message/sideOne/map_side_one_widget.dart';
import 'widget/message/sideOne/message_chat_side_one_widget.dart';
import 'widget/message/sideOne/message_video_side_one_widget.dart';
import 'widget/message/sideOne/music_side_one_widget.dart';
import 'widget/message/sideTwo/file_chat_side_two_widget.dart';
import 'widget/message/sideTwo/image_side_two_widget.dart';
import 'widget/message/sideTwo/map_side_two_widget.dart';
import 'widget/message/sideTwo/message_chat_side_two_widget.dart';
import 'widget/message/sideTwo/message_video_side_two_widget.dart';
import 'widget/message/sideTwo/music_side_two_widget.dart';
import 'widget/show_menu_bottom_sheet.dart';
import 'dart:io' as io;
class ConversationArguments {
  final String conversationId;
   String? userTwoImage;
   String? userTwoName;
   int? userTwoId;
  final String? user;


  ConversationArguments(  {
    required this.conversationId,
    required this.userTwoImage,
    required this.userTwoName,
    required this.userTwoId,
    required this.user
  });
}


class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);



  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

   ScrollController scrollController=ScrollController();
   ScrollController singleScrollController=ScrollController();
   TextEditingController textEditingController= TextEditingController();

   late ConversationBloc bloc;

   Channel? channelChat;
   FlutterAudioRecorder2? _recorder;
   Recording? _current;
   late RecordingStatus _currentStatus ;
   late Timer timer;
   int page=1;
   late bool conIdNotFound;
   late ConversationArguments? args;

   bool first=true;

   @override
  void initState() {


     _init();


    super.initState();
  }

   initWithContext(BuildContext context){
     if(first)
       {
         args =
         ModalRoute.of(context)!.settings.arguments! as ConversationArguments? ;
         if(args!.user!=null)
           {
             UserData user=UserData.fromJson(
                 json.decode(args!.user!));
             args!.userTwoImage=user.img;
             args!.userTwoName=user.name;
             args!.userTwoId=user.id;
           }

         bloc=sl<ConversationBloc>();
         if(args!.conversationId=="-1")
         {

           bloc.onGetConversationIdEvent(args!.userTwoId!);
           conIdNotFound=true;
         }
         else{
           bloc.onGetConversationMessage(
               args!.conversationId,page
           );
           conIdNotFound=false;
         }

         scrollController.addListener(() {
           if (scrollController.position.atEdge) {
             bool isTop = scrollController.position.pixels == 0;
             if (isTop) {
               page++;
               bloc.onGetConversationMessage(
                   args!.conversationId,page
               );

             } else {

             }
           }
         });





         channelChat =
             Global.pusher!.subscribe("chat.privet."+args!.conversationId);
         print("chat.${args!.conversationId}");
         print("chat.anas");
         channelChat!.bind('App\\Events\\ChatEvent', (event) {

           log("event.sssda()");

           Map<String,dynamic> arguments =
           (json.decode(event!.data!)??{}) as Map<String,dynamic>;

           PrivateMessagePusherModel message=
           PrivateMessagePusherModel.fromJson(arguments);
           UserData user=UserData.fromJson(arguments['user']);
           message.msg.user=user;
           if(user.id!=Global.userId)
           {
             bloc.onAddMessageFromPusherEvent(message.msg);
           }

           Future.delayed(const Duration(milliseconds: 300)).then((value) {
             scrollController.animateTo(scrollController.position.maxScrollExtent
                 , duration: const Duration(milliseconds: 500),
                 curve: Curves.linearToEaseOut);
           });
         });
         first=false;
       }
   }

   _init() async {
     try {
       bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

       if (hasPermission) {
         String customPath = '/flutter_audio_recorder_';
         io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
         if (io.Platform.isIOS) {
           appDocDirectory = await getApplicationDocumentsDirectory();
         } else {
           appDocDirectory = (await getExternalStorageDirectory())!;
         }

         customPath = appDocDirectory.path +
             customPath +
             DateTime.now().millisecondsSinceEpoch.toString();


         _recorder =
             FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.AAC);

         await _recorder!.initialized;

         var current = await _recorder!.current(channel: 0);
         print(current);
         setState(() {
           _current = current;
           _currentStatus = current!.status!;
           print(_currentStatus);
         });
       } else {
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content:  Text("You must accept permissions")));
       }
     } catch (e) {
       print(e);
     }
   }

   _start() async {
     try {
       await _recorder!.start();
       var recording = await _recorder!.current(channel: 0);
       setState(() {
         _current = recording;
       });

       const tick =  Duration(milliseconds: 50);
       Timer.periodic(tick, (Timer t) async {
         if (_currentStatus == RecordingStatus.Stopped) {
           t.cancel();
         }

         var current = await _recorder!.current(channel: 0);
         // print(current.status);
         setState(() {
           _current = current;
           _currentStatus = _current!.status!;
         });
       });
     } catch (e) {
       print(e);
     }
   }

   _stop() async {
     var result = await _recorder!.stop();

     setState(() {
       _current = result;
       _currentStatus = _current!.status!;
     });
   }
   int countSecond = 0;

   void startTimer() {
     countSecond=0;
     bloc.onChangeRecordTimerEvent(
         countSecond
     );
     const oneSec =  Duration(seconds: 1);
     timer =  Timer.periodic(
       oneSec,
           (Timer timer) {
         countSecond++;
         bloc.onChangeRecordTimerEvent(
             countSecond
         );
       },
     );
   }

   void closeTimer() {
     timer.cancel();
   }

   bool checkIsVideo(String? endUrl,String? localFile)
   {
     if(endUrl!=null)
     {
       if(endUrl.contains('mp4')
           ||endUrl.contains('mov')
           ||endUrl.contains('wmv')
           ||endUrl.contains('avi')
           || endUrl.contains('3gp')
           ||endUrl.contains('flv'))
       {
         return true;
       }
     }
     if(localFile!=null)
     {
       if (localFile.contains('mp4')
           ||localFile.contains('mov')
           ||localFile.contains('wmv')
           || localFile.contains('3gp')
           ||localFile.contains('avi')
           ||localFile.contains('flv'))
       {
         return true;
       }
     }

     return false;
   }

   bool checkIsImage(String? endUrl,String? localFile)
   {
     if(endUrl!=null)
     {
       endUrl= endUrl.substring(endUrl.length-4,endUrl.length);
       if(endUrl.contains('jpeg')
           ||endUrl.contains('jpg')
           ||endUrl.contains('png')
           ||endUrl.contains('gif')
       )
       {
         return true;
       }

     }
     if(localFile!=null)
     {
       if(localFile.contains('jpeg')
           ||localFile.contains('jpg')
           ||localFile.contains('png')
           ||localFile.contains('gif'))
       {
         return true;
       }
     }


     return false;
   }


   bool checkIsMusic(String? endUrl,String? localFile)
   {
     if(endUrl!=null)
     {
       endUrl= endUrl.substring(endUrl.length-4,endUrl.length);
       if(endUrl.contains('mp3')
           ||endUrl.contains('wav')
           ||endUrl.contains('m4a')
           ||endUrl.contains('aac')

       )
       {
         return true;
       }

     }
     if(localFile!=null)
     {
       if(localFile.contains('mp3')
           ||localFile.contains('wav')
           ||localFile.contains('m4a')
           ||localFile.contains('aac')
       )
       {
         return true;
       }
     }


     return false;
   }

   bool checkIsFile(String? endUrl,String? localFile)
   {
     if(endUrl!=null)
     {
       endUrl= endUrl.substring(endUrl.length-4,endUrl.length);
       if(endUrl.contains('pdf')
           ||endUrl.contains('ppt')
           ||endUrl.contains('docx')
       )
       {
         return true;
       }
     }
     if(localFile!=null)
     {
       if(localFile.contains('pdf')
           ||localFile.contains('ppt')
           ||localFile.contains('docx'))

       {
         return true;
       }
     }


     return false;
   }

   bool checkIsMap(String? endUrl)
   {

     if(endUrl!=null)
     {

       if(endUrl.contains('google.com/maps'))
       {
         return true;
       }
     }


     return false;
   }


  @override
  Widget build(BuildContext context) {
    initWithContext(context);
    return BlocConsumer<ConversationBloc,ConversationState>(
      bloc:bloc ,
      listener: (context, state) {
        if(state.smile.isNotEmpty)
        {
          textEditingController
            ..text += state.smile
            ..selection = TextSelection.fromPosition(
                TextPosition(offset: textEditingController.text.length));
        }
         if(state.isSuccess!)
           {
             Future.delayed(const Duration(seconds: 1)).
             then((value) {
               scrollController.jumpTo(
                  scrollController.position.maxScrollExtent);
             });
           }
         if(state.sendMessageModel.data!.conversation_id!>-1)
           {
               if(conIdNotFound)
                 {

                   channelChat =
                       Global.pusher!.subscribe("chat.privet.${state.sendMessageModel.data!.conversation_id}");

                   conIdNotFound=false;
                 }
           }
         if(state.getConversationIdModel.data!.isNotEmpty)
           {
             if(state.getConversationIdModel.data![0].messages!.isNotEmpty){
               bloc.onGetConversationMessage(
                   state.getConversationIdModel.
                   data![0].messages![0].conversation_id!,page
               );
             }
           }
      },
      builder: (context, state) {
        return  KeyboardAware(
          builder: (context, keyboardConfig) {
            return KeyboardVisibilityBuilder(
              builder: (context , bool isKeyboardVisible) {
                if(isKeyboardVisible)
                {
                  bloc.onShowEmojiEvent(false);
                }
                return SafeArea(
                  child: WillPopScope(
                    onWillPop: () async {

                      if(state.showEmoji)
                      {
                        if(state.showEmoji)
                        {
                          bloc.onShowEmojiEvent(false);
                          FocusScope.of(context).unfocus();
                          return false;
                        }

                        return true;
                      }
                      else{
                        return true;
                      }


                    },
                    child: Scaffold(

                      appBar: AppBar(
                        toolbarHeight: 80.h,
                        actions: [
                          Container(
                            width: 1.sw,
                            decoration:  BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).primaryColor,
                                    ]
                                )
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 6.h
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 20.w,
                                      color: ColorManager.backgroundColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50.h,
                                    height: 50.h,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      args!.userTwoImage??
                                          "https://www.room.tecknick.net/WI.jpeg",
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,

                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 6.w,),
                                  Expanded(child:
                                  Text( args!.userTwoName??'',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17.sp,
                                        color: ColorManager.backgroundColor,
                                        fontFamily: 'Roboto'
                                    ),
                                  ),),
                                  SizedBox(width: 15.w,),
                                  IconButton(

                                    onPressed: (){

                                    },
                                    icon: SvgPicture.asset('assets/icons/phone.svg',
                                      width: 19.w,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: (){
                                      showMenuBottomSheet(
                                          ctx: context,
                                          userTwoId: args!.userTwoId!,
                                          bloc: bloc
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/menu.svg',
                                      width: 4.5.w,
                                    ),
                                  ),




                                ],
                              ),
                            ),



                          )
                        ],
                      ),
                      body: SizedBox(
                        height: 1.sh-100.h,
                        child: Column(
                          children: [
                            //appBar


                            SizedBox(
                              height: 25.h,
                            ),

                            if(state.isLoading!)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                            //المحادثة
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,

                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()
                                ),
                                itemCount: state.privateOldMessageModel.data!.length,


                                itemBuilder: (context, index){

                                  if(Global.userId==state.
                                  privateOldMessageModel
                                      .data![index].user!.id)
                                  {

                                    if(checkIsVideo(
                                        state.
                                        privateOldMessageModel.data![index].all_file!=null?
                                        state.
                                        privateOldMessageModel.data![index].all_file!.substring(state.
                                        privateOldMessageModel.data![index].all_file!.length-4,
                                            state.privateOldMessageModel
                                                .data![index].all_file!.length):null,state.
                                    privateOldMessageModel.data![index].localFile))
                                    {
                                      return SizedBox(
                                        height: 170.h,
                                        child: MessageVideoSideOne(
                                          message:state.
                                          privateOldMessageModel
                                              .data![index] ,
                                        ),
                                      );
                                    }
                                    else if(checkIsImage(
                                        state.
                                        privateOldMessageModel.data![index].all_file
                                        ,state.
                                    privateOldMessageModel.data![index].localFile))
                                    {
                                      return SizedBox(
                                        height: 170.h,
                                        child: MessageImageSideOne(
                                          message:state.
                                          privateOldMessageModel
                                              .data![index] ,
                                        ),
                                      );
                                    }
                                    else if(checkIsFile(state.
                                    privateOldMessageModel.data![index].all_file,
                                        state.
                                        privateOldMessageModel.data![index].localFile
                                    ))
                                    {
                                      return MessageFileSideOne(
                                        message:state.
                                        privateOldMessageModel
                                            .data![index] ,
                                      );
                                    }
                                    else if(checkIsMusic(state.
                                    privateOldMessageModel.data![index].all_file,
                                        state.
                                        privateOldMessageModel.data![index].localFile
                                    ))
                                    {
                                      return SizedBox(
                                        height: 100.h,
                                        child: MessageMusicSideOne(
                                          message:state.
                                          privateOldMessageModel
                                              .data![index] ,
                                        ),
                                      );
                                    }
                                    else if(checkIsMap(state.
                                    privateOldMessageModel.data![index].message,
                                    ))
                                    {
                                      return MessageMapSideOne(
                                        message:state.
                                        privateOldMessageModel
                                            .data![index] ,
                                      );
                                    }
                                    return MessageChatSideOne(
                                      message:state.
                                      privateOldMessageModel
                                          .data![index] ,
                                    );
                                  }
                                  else
                                  if(
                                  checkIsVideo(state.
                                  privateOldMessageModel.data![index].all_file,
                                      state.
                                      privateOldMessageModel.data![index].localFile
                                  )
                                  )
                                  {
                                    return SizedBox(
                                      height: 170.h,
                                      child: MessageVideoSideTwo(
                                        message:state.
                                        privateOldMessageModel
                                            .data![index] ,
                                      ),
                                    );
                                  }
                                  else if(checkIsImage(state.
                                  privateOldMessageModel.data![index].all_file,
                                      state.
                                      privateOldMessageModel.data![index].localFile
                                  ))
                                  {
                                    return SizedBox(
                                      height: 170.h,
                                      child: MessageImageSideTwo(
                                        message:state.
                                        privateOldMessageModel
                                            .data![index] ,
                                      ),
                                    );
                                  }
                                  else if(checkIsMusic(state.
                                  privateOldMessageModel.data![index].all_file,
                                      state.
                                      privateOldMessageModel.data![index].localFile
                                  ))
                                  {
                                    return SizedBox(
                                      height: 100.h,
                                      child: MessageMusicSideTwo(
                                        message:state.
                                        privateOldMessageModel
                                            .data![index] ,
                                      ),
                                    );
                                  }

                                  else{
                                    if(
                                    checkIsVideo(state.
                                    privateOldMessageModel.data![index].all_file,
                                        state.
                                        privateOldMessageModel.data![index].localFile
                                    )
                                    )
                                    {
                                      return SizedBox(
                                        height: 170.h,
                                        child: MessageVideoSideTwo(
                                          message:state.
                                          privateOldMessageModel
                                              .data![index] ,
                                        ),
                                      );
                                    }
                                    else if(checkIsImage(state.
                                    privateOldMessageModel.data![index].all_file,
                                        state.
                                        privateOldMessageModel.data![index].localFile
                                    ))
                                    {
                                      return SizedBox(
                                        height: 170.h,
                                        child: MessageImageSideTwo(
                                          message:state.
                                          privateOldMessageModel
                                              .data![index] ,
                                        ),
                                      );
                                    }
                                    else if(checkIsMusic(state.
                                    privateOldMessageModel.data![index].all_file,
                                        state.
                                        privateOldMessageModel.data![index].localFile

                                    ))
                                    {
                                      return SizedBox(
                                        height: 100.h,
                                        child: MessageMusicSideTwo(
                                          message:state.
                                          privateOldMessageModel
                                              .data![index] ,
                                        ),
                                      );
                                    }
                                    else if(checkIsFile(state.
                                    privateOldMessageModel.data![index].all_file,
                                        state.
                                        privateOldMessageModel.data![index].localFile

                                    ))
                                    {
                                      return MessageFileSideTwo(
                                        message:state.
                                        privateOldMessageModel
                                            .data![index] ,
                                      );
                                    }
                                    else if(checkIsMap(state.
                                    privateOldMessageModel.data![index].message,
                                    ))
                                    {
                                      return MessageMapSideTwo(
                                        message:state.
                                        privateOldMessageModel
                                            .data![index] ,
                                      );
                                    }
                                  }
                                  return MessageChatSideTwo(
                                    message:state.
                                    privateOldMessageModel
                                        .data![index] ,
                                  );
                                },
                                separatorBuilder:(context, i){
                                  return  SizedBox(
                                    height: 5.h,
                                  );

                                },
                              ),
                            ),



                            //write message
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 15.w),
                              child:  Row(
                                children: [

                                  //record_not_enable
                                  if(!state.isRecord)
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          InkWell(
                                            onTap: ()async{
                                              if(FocusScope.of(context).hasFocus)
                                              {
                                                FocusManager.instance.primaryFocus!.unfocus(

                                                );
                                              }

                                              Future.delayed(const Duration(milliseconds: 300))
                                                  .then((value) {
                                                bloc.onShowEmojiEvent(true);

                                              });

                                            },
                                            child: SvgPicture.asset('assets/icons/smile.svg',
                                              width: 19.w,
                                              color: Theme.of(context).cursorColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              controller: textEditingController,
                                              onEditingComplete:(){
                                                FocusScope.of(context).unfocus();
                                                bloc.onShowEmojiEvent(false);
                                              },
                                              onSubmitted: (st){
                                                FocusScope.of(context).unfocus();
                                                bloc.onShowEmojiEvent(false);
                                              },
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Theme.of(context).primaryColorDark,
                                                height: 1.5.h,

                                              ),
                                              cursorColor: Theme.of(context).primaryColorDark,
                                              decoration:  InputDecoration(

                                                contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                ),


                                                enabledBorder:  UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Theme.of(context).cursorColor),
                                                ),
                                                focusedBorder:  UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Theme.of(context).cursorColor),
                                                ),
                                                disabledBorder:UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Theme.of(context).cursorColor),
                                                ) ,
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Theme.of(context).cursorColor),
                                                ) ,


                                                hintText:  tr('write message'),
                                                hintStyle: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Theme.of(context).cursorColor,
                                                ),
                                                focusColor: Theme.of(context).cursorColor,
                                                fillColor: Theme.of(context).cursorColor,


                                              ),


                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),

                                          InkWell(
                                            onTap: (){
                                              showMediaBottomSheet(bloc: bloc,ctx: context,
                                               userIdTwo: args!.userTwoId!
                                              );
                                            },
                                            child: SvgPicture.asset('assets/icons/media.svg',
                                              width: 19.w,
                                              color: Theme.of(context).cursorColor,
                                            ),
                                          ),





                                        ],
                                      ),
                                    ),
                                  //record_enable
                                  if(state.isRecord)
                                    Expanded(
                                      child: Row(
                                        children:  [


                                          Expanded(


                                            child: DragTarget(
                                              builder: (context, candidateData, rejectedData) {
                                                 return  Center(child:
                                                  Text('Slide to cancel    ${ state.recordTime}}', style:
                                                  TextStyle(color: Theme.of(context).primaryColorDark,
                                                    fontSize: 15.sp),));
                                              },
                                              onWillAccept: (data) {
                                                return true;
                                              },
                                              onAccept: (data) {

                                                bloc.onStartRecord(false);
                                                closeTimer();
                                                _stop();

                                              },
                                            ),
                                          ),
                                          IconButton(onPressed: ()async{
                                            bloc.onStartRecord(false);
                                            closeTimer();
                                            await _stop();
                                            bloc.onSendMessageEvent('',
                                                args!.userTwoId!,
                                                io.File(_current!.path!));
                                          }, icon: const Icon(
                                            Icons.send,
                                            color: ColorManager.primaryColor,

                                          ))
                                        ],
                                      ),
                                    ),
                                  if(!isKeyboardVisible)
                                  GestureDetector(
                                    onTap: (){
                                      bloc.onStartRecord(true);
                                      _start();
                                      startTimer();
                                    },

                                    child: Draggable(
                                      ignoringFeedbackSemantics: false,
                                      data: 5,
                                      axis: Axis.horizontal,
                                      child: Container(

                                        decoration:  BoxDecoration(
                                            color:state.isRecord?
                                            ColorManager.primaryColor:Colors.transparent,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SvgPicture.asset('assets/icons/micro.svg',
                                            width: 17.w,
                                            color:state.isRecord?
                                            ColorManager.backgroundColor:
                                            Theme.of(context).cursorColor,
                                          ),
                                        ),
                                      ),
                                      feedback:state.isRecord? Container(

                                        decoration:  const BoxDecoration(
                                            color:
                                            ColorManager.primaryColor,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SvgPicture.asset('assets/icons/micro.svg',
                                              width: 17.w,
                                              color:
                                              ColorManager.backgroundColor
                                          ),
                                        ),
                                      ):const SizedBox(),
                                    ),
                                  )
                                  else
                                    IconButton(onPressed: (){
                                       if(textEditingController.text.isNotEmpty)
                                         {
                                           bloc.onSendMessageEvent(
                                               textEditingController.text,
                                               args!.userTwoId!,null);
                                           textEditingController.clear();
                                         }

                                      bloc.onStartRecord(false);
                                    }, icon:  Icon(
                                      Icons.send,
                                      color: state.isRecord?
                                      ColorManager.backgroundColor:
                                      Theme.of(context).cursorColor,
                                      size: 22.w,
                                    )),
                                  SizedBox(
                                    width: 5.w,
                                  ),

                                ],
                              ),
                            ),


                            Offstage(
                              offstage: !state.showEmoji,
                              child: SizedBox(
                                height: 250.h,
                                child: EmojiPicker(
                                    onEmojiSelected: (Category category, Emoji emoji) {
                                      textEditingController
                                        ..text += emoji.emoji
                                        ..selection = TextSelection.fromPosition(
                                            TextPosition(offset: textEditingController.text.length));
                                    },
                                    onBackspacePressed: (){
                                      bloc.onShowEmojiEvent(false);

                                    },
                                    config: Config(
                                        columns: 7,
                                        // Issue: https://github.com/flutter/flutter/issues/28894
                                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                                        verticalSpacing: 0,
                                        horizontalSpacing: 0,
                                        initCategory: Category.RECENT,
                                        bgColor: const Color(0xFFF2F2F2),
                                        indicatorColor: Colors.blue,
                                        iconColor: Colors.grey,
                                        iconColorSelected: Colors.blue,
                                        progressIndicatorColor: Colors.blue,
                                        backspaceColor: Colors.blue,
                                        skinToneDialogBgColor: Colors.white,
                                        skinToneIndicatorColor: Colors.grey,
                                        enableSkinTones: true,
                                        showRecentsTab: true,
                                        recentsLimit: 28,
                                        noRecentsText: tr('No Recents'),
                                        noRecentsStyle:  TextStyle(
                                            fontSize: 20.sp, color: Colors.black26),
                                        tabIndicatorAnimDuration: kTabScrollDuration,
                                        categoryIcons: const CategoryIcons(),
                                        buttonMode: ButtonMode.MATERIAL)),
                              ),
                            ),

                          ],
                        ),
                      ),


                    ),
                  ),
                );
              },

            );
          },


        );
      },

    );
  }

  @override
  void dispose() {

    super.dispose();
  }

}
