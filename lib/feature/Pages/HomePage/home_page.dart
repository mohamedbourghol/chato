import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/Globals.dart';
import 'package:chato/Preference.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/feature/Pages/HomePage/bloc/home_bloc.dart';
import 'package:chato/feature/Pages/HomePage/bloc/home_state.dart';
import 'package:chato/feature/Pages/HomePage/widget/more_story.dart';
import 'package:chato/feature/Pages/HomePage/widget/search_friends.dart';
import 'package:chato/feature/autho/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:status_view/status_view.dart';
import 'package:story_maker/story_maker.dart';
import '../../../core/utils/color_manager.dart';
import '../../Conversation/conversation.dart';
import '../../User/user.dart';
import 'widget/friendship_requests.dart';

class HomeScreen extends StatefulWidget {
  final HomeBloc bloc;
  const HomeScreen({Key? key,required this.bloc}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  File? image;

  @override
  void initState() {
    widget.bloc.onGetStatusEvent();
    widget.bloc.onGetAllFriendEvent();
    widget.bloc.onGetFriendshipRequestsEvent();
    super.initState();
  }

  bool checkIsImage(String? endUrl) {
    if (endUrl != null) {
      endUrl = endUrl.substring(endUrl.length - 4, endUrl.length);
      if (endUrl.contains('jpeg') ||
          endUrl.contains('jpg') ||
          endUrl.contains('png') ||
          endUrl.contains('gif')) {
        return true;
      }
    }


    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<HomeBloc,HomeState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if(state.error.isNotEmpty)
          {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.primaryColor,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        if(state.allFriendModel.message!.contains('Unauthenticated.'))
          {
            Global.userToken='';
            Preferences.saveUserToken('');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen(),));
          }
      },
      builder: (context, state) {
        return Scaffold(

          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: 1.sh,
              child: Stack(
                children: [
                  Column(
                    children: [
                      //appBar
                      SizedBox(
                        width: 1.sw,


                        child: Padding(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [

                                  SizedBox(width: 6.w,),
                                  Expanded(child:  Text('Friends',
                                    style: TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19.sp ,

                                    ),
                                  ).tr(),),


                                  SizedBox(width: 6.w,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                        FriendshipRequests(bloc: widget.bloc,)),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.w),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Theme.of(context).primaryColor,
                                              Theme.of(context).primaryColorLight,
                                            ]),

                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 7.h
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/add.svg',
                                              width: 13.w,
                                              color: ColorManager.backgroundColor,
                                            ),
                                            SizedBox(width: 5.w,),
                                            Text('+'+state.friendshipRequestsModel.data!.length.toString(),
                                              style: getMediumStyle(
                                                color: ColorManager.backgroundColor,
                                                fontSize: 15.sp,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),



                      ),


                      //add && friend
                      SizedBox(
                        height: 10.h,
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,



                        child:    SizedBox(
                          width:state.getStatusModel.data==null|| state.getStatusModel.data!.length<4?
                          1.sw:null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              GestureDetector(
                                onTap: () async {

                                  await [
                                    Permission.photos,
                                    Permission.storage,
                                  ].request();
                                  FilePickerResult? picker =
                                  await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'png','jpeg','gif',
                                      'mp4','mov','wmv','avi','3gp','flv'  ],
                                  );

                                  if (picker != null) {
                                    File? file = File(picker.files.single.path!,);
                                    if(file!=null) {
                                      if(checkIsImage(file.path))
                                        {
                                          final File editedFile = await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => StoryMaker(
                                                filePath: file.path,
                                              ),
                                            ),
                                          );
                                          image = editedFile;
                                          widget.bloc.onAddStatusEvent(status: image!);
                                          print('editedFile: ${image!.path}');
                                        }
                                      else{
                                        image = file;
                                        widget.bloc.onAddStatusEvent(status: image!);
                                        print('editedFile: ${image!.path}');
                                      }



                                    }
                                  }
                                  else {
                                    // User canceled the picker
                                  }

                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 0.09.sh,
                                          height:  0.09.sh,
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    ColorManager.primaryColor,
                                                    ColorManager.primaryColorLight,
                                                  ]
                                              ),
                                              shape: BoxShape.circle

                                          ),
                                          child: Icon(Icons.add,
                                            size: 25.w,
                                            color:    ColorManager.lightGreyShade200,
                                          ),
                                        ),


                                      ],
                                    ),
                                    SizedBox(
                                      width: 75.w,
                                      child: Text('Add Story',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'DIN',
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).disabledColor
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ).tr(),
                                    )
                                  ],
                                ),
                              ),


                              if(state.getStatusModel.data!=null)
                                for(int index=0;index<state.getStatusModel.data!.length;index=index+1)
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Column(
                                        children: [
                                          state.getStatusModel.
                                          data![index].img!=null?
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return  MoreStories(
                                                statusUser:state.getStatusModel.
                                                data![index].status_users! ,
                                                me: true,
                                                  bloc: widget.bloc,
                                                  index: index,
                                                );
                                              },));
                                            },
                                            child: StatusView(
                                              radius: 33.w,
                                              spacing: 12,
                                              strokeWidth: 2,
                                              indexOfSeenStatus: state.seenStatus[index],
                                              numberOfStatus: state.getStatusModel.
                                              data![index].status_users!.length,
                                              padding: 3.5,
                                              centerImageUrl: state.getStatusModel.
                                              data![index].status!,
                                              seenColor: Colors.grey,
                                              unSeenColor: Colors.green,

                                            ),
                                          ):
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return  MoreStories(
                                                  statusUser:state.getStatusModel.
                                                  data![index].status_users! ,
                                                  me: true,
                                                  bloc: widget.bloc,
                                                  index: index,
                                                );
                                              },));
                                            },
                                            child: StatusView(
                                              radius: 33.w,
                                              spacing: 12,
                                              strokeWidth: 2,
                                              indexOfSeenStatus: state.seenStatus[index],
                                              numberOfStatus: state.getStatusModel.
                                              data![index].status_users!.length,
                                              padding: 3.5,
                                              centerImageUrl: state.getStatusModel.
                                              data![index].img??"https://www.room.tecknick.net/WI.jpeg",
                                              seenColor: Colors.grey,
                                              unSeenColor: Colors.green,

                                            ),
                                          ),

                                          SizedBox(
                                            height: 3.h,
                                          ),

                                          SizedBox(
                                            width: 70.w,
                                            child: Text(
                                              state.getStatusModel.data![index].id==Global.userId?
                                                  'My Status':
                                              state.getStatusModel.data![index].name!,
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
                                      ),
                                    ],
                                  ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      //المحادثات
                      Expanded(
                        child:
                            state.isLoadingGetAllFriend!?const Center(
                              child: CircularProgressIndicator(),
                            ):
                            state.allFriendModel.data!=null&&
                        state.allFriendModel.data!.isNotEmpty?
                        RefreshIndicator(
                          onRefresh: ()async{
                            widget.bloc.onGetAllFriendEvent();
                            widget.bloc.onGetStatusEvent();
                          },
                          child: ListView.separated(

                            physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()
                            ),
                            itemCount: state.allFriendModel.data!.length,
                            itemBuilder: (context, index){

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, '/conversationScreen',
                                            arguments: ConversationArguments(
                                              user: null,
                                              userTwoId:state.allFriendModel.data![index].id! ,
                                              userTwoName: state.allFriendModel.data![index].name,
                                              userTwoImage: state.allFriendModel.data![index].img,
                                              conversationId: '-1',
                                            )
                                        );

                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width:state.allFriendModel.
                                            data![index].vip_user==null?70.w: 60.w,
                                            height: state.allFriendModel.
                                            data![index].vip_user==null?70.w: 60.w,
                                            child: CachedNetworkImage(
                                              imageUrl: state.allFriendModel.
                                              data![index].img ??
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
                                          if(state.allFriendModel.
                                          data![index].vip_user!=null)
                                            Image.asset(
                                              state.allFriendModel.
                                              data![index].vip_user!.vip_id=="1"?
                                              'assets/images/solider_frame.png':
                                              state.allFriendModel.
                                              data![index].vip_user!.vip_id=='2'?
                                              'assets/images/knight_frame.png':
                                              state.allFriendModel.
                                              data![index].vip_user!.vip_id=='3'?
                                              'assets/images/minister_frame.png':
                                              'assets/images/king_frame.png',
                                              fit: BoxFit.fill,
                                              height: state.allFriendModel.
                                              data![index].vip_user!.vip_id=="1"?75.w:
                                              state.allFriendModel.data![index].vip_user!.vip_id=="3"?
                                             103.w: 85.w,
                                              width: state.allFriendModel.
                                              data![index].vip_user!.vip_id=="1"?75.w:state.allFriendModel.data![index].vip_user!.vip_id=="3"?
                                              103.w:  85.w,
                                            ),
                                           if(state.allFriendModel.
                                           data![index].online=='1')
                                             ...[
                                               if(Localizations.localeOf(context)==const Locale('ar','AR'))
                                                 Positioned(
                                                   top:state.allFriendModel.data![index].vip_user!=null&&state.allFriendModel.data![index].vip_user!.vip_id=="3"?20.h: 7.h,
                                                   left:state.allFriendModel.data![index].vip_user!=null&&state.allFriendModel.data![index].vip_user!.vip_id=="3"?20.w: 5.w,
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
                                                 )
                                             ]
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 4.w,),
                                    Expanded(
                                      flex: 3,

                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(state.allFriendModel.data![index]
                                                    .name!,
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
                                                child: Text(state.allFriendModel.
                                                data![index].status!,
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
                                            child: Text('',
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
                              );

                            },
                            separatorBuilder:(context, i){
                              return  SizedBox(
                                height: 5.h,
                              );

                            },
                          ),
                        ):
                            RefreshIndicator(
                              onRefresh: ()async{
                                widget.bloc.onGetAllFriendEvent();
                                widget.bloc.onGetStatusEvent();
                              },
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: 0.6.sh,
                                    child: Center(
                                      child: Text(state.error.isNotEmpty?
                                      state.error:
                                      'No Friends',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Theme.of(context).primaryColorDark
                                        ),
                                      ).tr(),
                                    ),
                                  ),
                                ],

                              ),
                            )

                        ,),

                      SizedBox(
                        height: 95.h,
                      ),

                    ],
                  ),
                  Positioned(
                    bottom: 110.h,
                    left:context.locale==const Locale('ar', 'AR')?
                    -240.w:240.w,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              SearchFriendsScreen(bloc: widget.bloc,)),
                        );
                      },
                      child: Container(


                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  ColorManager.primaryColor,
                                  ColorManager.primaryColorLight,
                                ]
                            ),
                            shape: BoxShape.circle

                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(14.0.w),
                          child: Icon(Icons.add,
                            size: 25.w,
                            color:    ColorManager.lightGreyShade200,
                          ),
                        ),
                      ),
                    ),
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
  bool get wantKeepAlive => true;
}
