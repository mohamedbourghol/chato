import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/feature/User/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../bloc/room_conversation_bloc.dart';
import '../../bloc/room_conversation_state.dart';



Future<String?> showVipBottomSheet(
    BuildContext ctx,
    RoomConversationBloc bloc,
    int roomId,
    int ownerId

    ) async {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.w),
          topRight: Radius.circular(30.w),
        ),
      ),
      builder: (ctx) =>
          BlocConsumer<RoomConversationBloc,RoomConversationState>(
           bloc: bloc,
           listener: (context, state){
             if(state.isSuccessChangePer!)
               {
                 if(state.changePermeationModel.message!.isNotEmpty)
                   {
                     Fluttertoast.showToast(
                         msg: state.changePermeationModel.message!,
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 1,
                         backgroundColor: ColorManager.primaryColor,
                         textColor: Colors.white,
                         fontSize: 16.0
                     );
                   }

               }
             if(state.deleteUserModel.message!.isNotEmpty)
               {

                   Fluttertoast.showToast(
                       msg: state.deleteUserModel.message!,
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.BOTTOM,
                       timeInSecForIosWeb: 1,
                       backgroundColor: ColorManager.primaryColor,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );

               }
             if(state.blockUserModel.message.isNotEmpty)
             {

               Fluttertoast.showToast(
                   msg: state.blockUserModel.message,
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: ColorManager.primaryColor,
                   textColor: Colors.white,
                   fontSize: 16.0
               );

             }
           },
           builder: (context, state) {

            return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration:  BoxDecoration(
              color: Theme.of(ctx).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.center,
              width: 1.sw,
              height: 450.h,
            child:state.isLoadingChangePer!?
            const Center(
              child: CircularProgressIndicator(),
            ):
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('المتواجدين',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(ctx).primaryColorDark
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ).tr(),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                Expanded(
                  child:state.allTypeModel.data==null?
                  Center(
                    child: Text('No VIP',
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ).tr(),
                  ): ListView.separated(
                      itemBuilder: (context, index) {

                        if(state.allTypeModel.data![index].id!=Global.userId) {
                          return  Padding(
                            padding:  EdgeInsets.symmetric(
                                horizontal: 12.w,
                              vertical: 4.h
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (context) =>UserScreen(id:
                                        state.allTypeModel.data![index].id!,) ,));
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50.h,
                                        height: 50.h,
                                        child: CachedNetworkImage(
                                          imageUrl:state.allTypeModel.data![index].img??
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

                                      if(state.allTypeModel.data![index].vip_user!=null)
                                        SizedBox(
                                          width:state.allTypeModel.data![index].vip_user!.vip_id
                                              =="1"?64.h: 75.h,
                                          height: state.allTypeModel.data![index].vip_user!.vip_id
                                              =="1"?64.h: 75.h,
                                          child:Image.asset(
                                            state.allTypeModel.data![index].vip_user!.vip_id
                                                =="1"?
                                            'assets/images/solider_frame.png':
                                            state.allTypeModel.data![index].vip_user!.vip_id
                                                =="2"?
                                            'assets/images/knight_frame.png':
                                            state.allTypeModel.data![index].vip_user!.vip_id
                                                =="3"?
                                            'assets/images/minister_frame.png':
                                            'assets/images/king_frame.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 6.w,),
                                Expanded(
                                  child: Text(state.allTypeModel.data![index].name!,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColorDark
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),

                                if(ownerId==Global.userId||state.userPermission!='user')
                                  PopupMenuButton(
                                      color: ColorManager.darkPrimary,
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry>[
                                        if(ownerId==Global.userId||state.userPermission=='owner')
                                        PopupMenuItem(
                                          onTap: (){
                                            bloc.onChangePermeationUserEvent(
                                                roomId,
                                                state.allTypeModel.data![index].id!,
                                                'owner');
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/taj.svg',
                                                width: 13.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),

                                              Text('Make Owner',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorManager.backgroundColor
                                                ),
                                              ).tr(),
                                            ],
                                          ),
                                        ),
                                        if(ownerId==Global.userId||state.userPermission=='owner'||
                                            state.userPermission=='admin')
                                        PopupMenuItem(
                                          onTap: (){
                                            bloc.onChangePermeationUserEvent(
                                                roomId,
                                                state.allTypeModel.data![index].id!,
                                                'admin');
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/awesome-star.svg',
                                                width: 13.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),

                                              Text('Make Admin',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorManager.backgroundColor
                                                ),
                                              ).tr(),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: (){
                                            bloc.onChangePermeationUserEvent(
                                                roomId,
                                                state.allTypeModel.data![index].id!,
                                                'user');
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/awesome-user.svg',
                                                width: 13.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),

                                              Text('Make User',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorManager.backgroundColor
                                                ),
                                              ).tr(),
                                            ],
                                          ),
                                        ),


                                        PopupMenuItem(
                                          onTap: (){
                                            bloc.onDeleteUserEvent(state.allTypeModel.data![index].id!, roomId);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/go_out.svg',
                                                width: 8.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),

                                              Text('Expulsion',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorManager.backgroundColor
                                                ),
                                              ).tr(),
                                            ],
                                          ),
                                        ),

                                        PopupMenuItem(
                                          onTap: (){
                                            bloc.onBlockUserEvent(state.allTypeModel.data![index].id!, roomId);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/metro-blocked.svg',
                                                width: 13.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),

                                              Text('ban',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorManager.backgroundColor
                                                ),
                                              ).tr(),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: (){
                                            bloc.onBlockUserEvent(state.allTypeModel.data![index].id!, roomId);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/metro-blocked.svg',
                                                width: 13.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),

                                              Text('Permanent Ban',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ColorManager.backgroundColor
                                                ),
                                              ).tr(),
                                            ],
                                          ),
                                        ),

                                      ])




                              ],
                            )
                        );
                        }
                        else{
                          return   const SizedBox(
                          );
                        }
                      }, separatorBuilder: (context, index) {
                    return   const SizedBox(

                    );
                  }, itemCount:
                  state.allTypeModel.data!=null?
                  state.allTypeModel.data!.length:0),
                ),
                Divider(
                  thickness:1,
                  color: Theme.of(ctx).hintColor,
                ),
                SizedBox(height: 30.h,),

              ],
            ),
          );
        },

      ));
  return '';
}



