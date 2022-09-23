
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/feature/Pages/RoomPage/bloc/room_state.dart';
import 'package:chato/feature/Pages/RoomPage/widget/all_room.dart';
import 'package:chato/feature/Pages/RoomPage/widget/create_room.dart';
import 'package:chato/feature/Pages/RoomPage/widget/fav_room.dart';
import 'package:chato/feature/Pages/RoomPage/widget/global_room.dart';
import 'package:chato/feature/Pages/RoomPage/widget/trend_room.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/color_manager.dart';
import '../../../core/utils/styles_manager.dart';

import 'bloc/room_bloc.dart';


class RoomScreen extends StatefulWidget {
  final RoomBloc bloc;
  const RoomScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> with AutomaticKeepAliveClientMixin{

   List<String> filters=[
     tr('Global'),tr('Trend'),
     tr('Active'),tr('Fav')];

   PageController pageController=PageController();
  TextEditingController textEditingController=
      TextEditingController();


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<RoomBloc,RoomState>(
      bloc:widget.bloc,
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
                               Expanded(child:
                                Text('Rooms Chat',
                                style: getMediumStyle(
                                    color: ColorManager.primaryColor,
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
                      horizontal: 12.w
                    ),
                    child: TextFormField(
                      onChanged: (va){
                         widget.bloc.onSearchEvent(va);
                      },
                      controller: textEditingController,
                      style: TextStyle(
                          fontSize: FontSize.s16,
                          color:Global.darkMode? ColorManager.backgroundColor:
                          ColorManager.textColor
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5.h,
                            bottom: 10.h,right: 5,left: 5),
                        hintText: "search".tr(),
                        hintStyle: TextStyle(
                          color: ColorManager.hintText,
                          fontSize: 16.sp,
                        ),
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.hintText)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorManager.backgroundColor
                            )),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.hintText)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr('Enter a password');
                        }
                        else if(value.length<8) {
                          return tr('Password is short'.tr());
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  //filter

                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 6.w
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        for(int i=0;i<filters.length;i++)
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 12.w),
                            child: InkWell(
                              onTap: (){
                                widget.bloc.onChangeFilter(i);
                                pageController.jumpToPage(i);
                              },
                              child: Column(
                                children: [
                                  Container(

                                    decoration:  BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: state.selectedFilter==i?
                                                ColorManager.primaryColor:
                                                Theme.of(context).disabledColor
                                            )
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(filters[i],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: 'DIN',
                                            fontWeight: FontWeight.w500,
                                            color:state.selectedFilter==i?
                                                ColorManager.primaryColor:
                                            Theme.of(context).disabledColor
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  //rooms
                  Expanded(

                    child:
                    PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AllRoomPage(
                           bloc: widget.bloc,

                        ),
                        TrendRoomPage(
                           bloc: widget.bloc,
                        ),
                        GlobalRoomPage(
                           bloc: widget.bloc,
                        ),
                        FavRoomPage(
                           bloc: widget.bloc,
                        ),
                      ],
                    ),),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            CreateRoom(bloc: widget.bloc,)),
                      );
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topRight,
                            tileMode: TileMode.mirror,
                            colors: [

                              ColorManager.primaryColor,
                              ColorManager.primaryColorLight,


                            ]
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add,
                        size: 25.w,
                        color:    ColorManager.lightGreyShade200,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 95.h,
                  ),

                ],
              ),
            ),
          ),


        );
      },
      listener: (context, state) {},

    );
  }

  @override

  bool get wantKeepAlive => true;
}
