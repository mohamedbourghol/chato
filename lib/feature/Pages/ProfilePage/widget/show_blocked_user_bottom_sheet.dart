import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/feature/Pages/ProfilePage/bloc/prof_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/prof_bloc.dart';



Future<String?> showBlockedUserBottomSheet({
  required BuildContext ctx,
  required ProfBloc bloc,

  }) async {
  bloc.onGetBlockedUserEvent();
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
      builder: (ctx) => BlocBuilder<ProfBloc,ProfState>(
        bloc: bloc,
        builder: (context, state) {
          return StatefulBuilder(
            builder: (context, setState) {
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
                height: 350.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Blocked Users',
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
                      child:
                      state.blockedUserModel!.data!=null&&
                          state.blockedUserModel!.data!.isNotEmpty?
                      ListView.separated(

                          itemBuilder: (context, index) {
                            return  Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 12.w
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50.h,
                                      height: 50.h,
                                      child: CachedNetworkImage(
                                        imageUrl:state.blockedUserModel!.data![index].img
                                            ?? "https://www.room.tecknick.net/WI.jpeg"

                                        ,
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
                                    Expanded(
                                      child: Text(state.blockedUserModel!.data![index].name!,
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

                                    IconButton(onPressed: (){
                                      bloc.onUnBlockedUserEvent(
                                       state.blockedUserModel!.data![index].id!);
                                       state.blockedUserModel!.data!.removeAt(index);
                                          setState((){});
                                    },
                                        icon: SvgPicture.asset('assets/icons/trash.svg')),
                                  ],
                                )
                            );
                          }, separatorBuilder: (context, index) {
                        return  Divider(
                          thickness:1,
                          color: Theme.of(context).hintColor,
                        );
                      }, itemCount: state.blockedUserModel!.data!.length):
                      state.isLoading!?
                      const Center(
                        child: CircularProgressIndicator(),
                      ):
                      Center(
                        child: Text('No Blocked User',
                          style: TextStyle(
                            fontSize: 16.sp,

                          ),
                        ).tr(),
                      )


                      ,
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

          );
        },


      ));
  return '';
}
