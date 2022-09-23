import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/Globals.dart';
import 'package:chato/feature/Pages/ChatPage/bloc/chat_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/color_manager.dart';
import '../../Conversation/conversation.dart';
import 'bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
 final ChatBloc bloc;
  const ChatScreen({Key? key,required this.bloc}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    widget.bloc.onGetConversationPrivate();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ChatBloc,ChatState>(
      bloc: widget.bloc,
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: 1.sh,
              child: Column(
                children: [
                  //appBar
                  SizedBox(
                    width: 1.sw,

                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 20.h
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [

                              SizedBox(width: 6.w,),
                              Expanded(child:
                              Text('Chats',
                                style: TextStyle(
                                    color: ColorManager.primaryColor,

                                    fontWeight: FontWeight.w700,
                                    fontSize: 19.sp


                                ),
                              ).tr(),),




                            ],
                          ),

                        ],
                      ),
                    ),



                  ),


                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 6.w
                    ),
                    child: SizedBox(
                      height: 0.13.sh,

                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.getConversationPrivateModel.data!.length,
                        itemBuilder: (context, index){

                          return Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 57.w,
                                    height: 57.w,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          Global.userId==
                                              state.getConversationPrivateModel.data![index].user1!.id?
                                      state.getConversationPrivateModel.data![index].user2!.img??
                                      "https://www.room.tecknick.net/WI.jpeg":
                                          state.getConversationPrivateModel.data![index].user1!.img??
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
                                   if(false)
                                     ...[
                                       if(Localizations.localeOf(context)==const Locale('ar','AR'))
                                         Positioned(
                                           top: 5.h,
                                           left: 2.w,
                                           child: Container(


                                             width: 12.w,
                                             height: 12.w,
                                             decoration: const BoxDecoration(
                                               color: Color(0xff00EA11),
                                               shape: BoxShape.circle,
                                             ),
                                           ),
                                         )
                                       else
                                         Positioned(
                                           top: 5.h,
                                           right: 2.w,
                                           child: Container(


                                             width: 12.w,
                                             height: 12.w,
                                             decoration: const BoxDecoration(
                                               color: Color(0xff00EA11),
                                               shape: BoxShape.circle,
                                             ),
                                           ),
                                         ),
                                     ]
                                ],
                              ),
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  Global.userId==
                                      state.getConversationPrivateModel.data![index].user1!.id?
                                  state.getConversationPrivateModel.data![index].
                                  user2!.name!:
                                  state.getConversationPrivateModel.data![index].
                                  user1!.name!,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).disabledColor
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          );


                        },
                        separatorBuilder:(context, i){
                          return const SizedBox(



                          );

                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  //المحادثات
                  Expanded(
                    child:
                    state.isLoadingGet!?
                    const Center(child: CircularProgressIndicator()):
                    state.getConversationPrivateModel.data!.isEmpty?
                    RefreshIndicator(
                      onRefresh: () async{
                        widget.bloc.onGetConversationPrivate();
                      },
                      child: ListView(
                         children: [
                           SizedBox(height: 0.3.sh,),
                           Center(child: Text('No Chats',
                             style: TextStyle(
                               fontSize: 18.sp,


                             ),
                           ).tr()),
                         ],
                       ),
                    ):
                    RefreshIndicator(
                      onRefresh: ()async{
                        widget.bloc.onGetConversationPrivate();
                      },
                      child: ListView.separated(

                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()

                        ),

                        itemCount: state.getConversationPrivateModel.data!.length,
                        itemBuilder: (context, index){

                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/conversationScreen',
                                  arguments: ConversationArguments(
                                    user: null,
                                    conversationId: state.getConversationPrivateModel.data![
                                   index].message!
                                        .conversation_id,
                                    userTwoImage:
                                    Global.userId==
                                        state.getConversationPrivateModel.data![index].user1!.id?
                                    state.getConversationPrivateModel.data![index].
                                    user2!.img:
                                    state.getConversationPrivateModel.data![ index].
                                    user1!.img,
                                    userTwoName:
                                    Global.userId==
                                        state.getConversationPrivateModel.data![ index].user1!.id?
                                    state.getConversationPrivateModel.data![index].
                                    user2!.name:
                                    state.getConversationPrivateModel.data![ index].
                                    user1!.name,
                                    userTwoId:
                                    Global.userId==
                                        state.getConversationPrivateModel.data![index].user1!.id?
                                    state.getConversationPrivateModel.data![ index].
                                    user2!.id:
                                    state.getConversationPrivateModel.data![ index].
                                    user1!.id,
                                  )
                              );

                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 12.w
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: 60.w,
                                        height: 60.w,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          Global.userId==
                                              state.getConversationPrivateModel.data![ index].user1!.id?
                                          state.getConversationPrivateModel.data![ index].user2!.img??
                                              "https://www.room.tecknick.net/WI.jpeg":
                                          state.getConversationPrivateModel.data![ index].user1!.img??
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
                                     if(false)
                                       ...[
                                         if(Localizations.localeOf(context)==const Locale('ar','AR'))
                                           Positioned(

                                             left: 2.w,
                                             child: Container(

                                               child:  Padding(
                                                 padding:  EdgeInsets.symmetric(
                                                     horizontal: 5.w,
                                                     vertical: 1.5.w
                                                 ),
                                                 child: Text('5',
                                                   style: TextStyle(
                                                       fontSize: 10.sp,
                                                       color: ColorManager.backgroundColor,
                                                       fontWeight: FontWeight.w700
                                                   ),
                                                   textAlign: TextAlign.center,
                                                 ),
                                               ),
                                               decoration:  BoxDecoration(
                                                   gradient:const LinearGradient(

                                                       begin: Alignment.topRight,
                                                       end: Alignment.bottomLeft,
                                                       colors: [
                                                         ColorManager.primaryColor,
                                                         ColorManager.primaryColorLight,
                                                       ]
                                                   ) ,
                                                   borderRadius: BorderRadius.circular(
                                                       4.w
                                                   ),
                                                   shape: BoxShape.rectangle
                                               ),

                                             ),
                                           )
                                         else
                                           Positioned(

                                             right: 2.w,
                                             child: Container(

                                               child:  Padding(
                                                 padding:  EdgeInsets.symmetric(
                                                     horizontal: 5.w,
                                                     vertical: 1.5.w
                                                 ),
                                                 child: Text('5',
                                                   style: TextStyle(
                                                       fontSize: 10.sp,
                                                       color: ColorManager.backgroundColor,
                                                       fontWeight: FontWeight.w700
                                                   ),
                                                   textAlign: TextAlign.center,
                                                 ),
                                               ),
                                               decoration:  BoxDecoration(
                                                   gradient:const LinearGradient(

                                                       begin: Alignment.topRight,
                                                       end: Alignment.bottomLeft,
                                                       colors: [
                                                         ColorManager.primaryColor,
                                                         ColorManager.primaryColorLight,
                                                       ]
                                                   ) ,
                                                   borderRadius: BorderRadius.circular(
                                                       4.w
                                                   ),
                                                   shape: BoxShape.rectangle
                                               ),

                                             ),
                                           ),
                                       ]


                                    ],
                                  ),
                                  SizedBox(width: 4.w,),
                                  Expanded(
                                    flex: 3,

                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                Global.userId==
                                                    state.getConversationPrivateModel.data![ index].user1!.id?
                                                state.getConversationPrivateModel.data![ index].user2!.name!:
                                                state.getConversationPrivateModel.data![ index].user1!.name!,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context).disabledColor
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(state.getConversationPrivateModel
                                                  .data![ index].message!.message??'',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: 'DIN',
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context).hintColor
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w,),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(DateFormat('hh:mm a','en').format(state.getConversationPrivateModel.data!
                                          [ index].updated_at!)
                                            ,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontFamily: 'DIN',
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context).hintColor
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                        },
                        separatorBuilder:(context, i){
                          return  SizedBox(
                            height: 5.h,



                          );

                        },
                      ),
                    ),),
                  SizedBox(
                    height: 95.h,
                  ),

                ],
              ),
            ),
          ),

        );
      },

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
