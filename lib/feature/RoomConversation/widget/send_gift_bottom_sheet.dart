import 'package:cached_network_image/cached_network_image.dart';
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../bloc/room_conversation_bloc.dart';
import '../bloc/room_conversation_state.dart';

void sendGiftBottomSheet(BuildContext ctx,RoomConversationBloc bloc,int roomId) {
  bloc.onGetGiftEvent();
  bloc.onChangeGiftEvent(0);
  int selected=-1;
  int receiverId=-1;
  int giftId=-1;
  PageController pageController=PageController(
    initialPage: 0,
    keepPage: true,
  );
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: ColorManager.darkBackgroundColor,
      context: ctx,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.w),
          topRight: Radius.circular(30.w),
        ),

      ),

      builder: (ctx) =>
          BlocListener<RoomConversationBloc,
              RoomConversationState>(
            bloc: bloc,
            listener: (context, state) {
              if(state.sendGiftModel.message!.isNotEmpty){
                Fluttertoast.showToast(
                    msg: state.sendGiftModel.message!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: ColorManager.primaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            },
            child: BlocBuilder<RoomConversationBloc,
                RoomConversationState>(
              bloc: bloc,
              builder: (context, state) {
                return StatefulBuilder(
                  builder: (context, setState) =>
                      Container(

                        width: 1.sw,
                        height: 400.h,

                        alignment: Alignment.center,
                        child:state.isLoadingGetGift!?
                        const Center(child:CircularProgressIndicator() ,):
                        Column(
                          children: [
                            SizedBox(height: 20.h,),
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 6.w
                              ),
                              child: SizedBox(
                                height: 40.h,

                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.allTypeModel.data!.length,
                                  itemBuilder: (context, index){
                                    if(state.allTypeModel.data![index].id!=Global.userId) {
                                      return Padding(
                                        padding:  EdgeInsets.only(
                                            left: 6.w
                                        ),
                                        child: GestureDetector(
                                          onTap: (){
                                            selected=index;
                                            receiverId=state.allTypeModel.data![index].id!;

                                            setState((){});
                                            Fluttertoast.showToast(
                                                msg: state.allTypeModel.data![index].name!,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: ColorManager.primaryColor,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 35.h,
                                                height: 35.h,
                                                child: CachedNetworkImage(
                                                  imageUrl:state.allTypeModel.data![index].img!=null?
                                                  state.allTypeModel.data![index].img!:
                                                  "https://www.room.tecknick.net/WI.jpeg",
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: selected==index? Colors.white:Colors.transparent),
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

                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    else{
                                      return const SizedBox();
                                    }


                                  },
                                  separatorBuilder: (context, index){

                                    return const SizedBox();


                                  },

                                ),
                              ),
                            ),

                            SizedBox(height: 20.h,),
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 6.w
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      bloc.onChangeGiftEvent(0);
                                      pageController.jumpToPage(0);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/gift_5.svg',
                                          color: state.senGiftType==0?
                                          ColorManager.backgroundColor:
                                          ColorManager.hintText,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text('Gifts',style: TextStyle(
                                            color: state.senGiftType==0?
                                            ColorManager.backgroundColor:
                                            ColorManager.hintText,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600
                                        ),).tr()

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w,),
                                  GestureDetector(
                                    onTap: (){
                                      bloc.onChangeGiftEvent(1);
                                      pageController.jumpToPage(1);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/flag.svg',
                                          color: state.senGiftType==1?
                                          ColorManager.backgroundColor:
                                          ColorManager.hintText,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text('Flags',style: TextStyle(
                                            color: state.senGiftType==1?
                                            ColorManager.backgroundColor:
                                            ColorManager.hintText,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600
                                        ),).tr()

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w,),
                                  GestureDetector(
                                    onTap: (){
                                      bloc.onChangeGiftEvent(2);
                                      pageController.jumpToPage(2);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/star.svg',
                                          color: state.senGiftType==2?
                                          ColorManager.backgroundColor:
                                          ColorManager.hintText,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text('the rich',style: TextStyle(
                                            color: state.senGiftType==2?
                                            ColorManager.backgroundColor:
                                            ColorManager.hintText,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600
                                        ),).tr()

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w,),
                                  GestureDetector(
                                    onTap: (){
                                      bloc.onChangeGiftEvent(3);
                                      pageController.jumpToPage(3);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/vip.svg',
                                          color: state.senGiftType==3?
                                          ColorManager.backgroundColor:
                                          ColorManager.hintText,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text('vip',style: TextStyle(
                                            color: state.senGiftType==3?
                                            ColorManager.backgroundColor:
                                            ColorManager.hintText,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600
                                        ),).tr()

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w,),
                                  GestureDetector(
                                    onTap: (){
                                      bloc.onChangeGiftEvent(4);
                                      pageController.jumpToPage(4);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/featured.svg',
                                          color: state.senGiftType==4?
                                          ColorManager.backgroundColor:
                                          ColorManager.hintText,
                                          width: 18.sp,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text('Featured',style: TextStyle(
                                            color: state.senGiftType==4?
                                            ColorManager.backgroundColor:
                                            ColorManager.hintText,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600
                                        ),).tr()

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Expanded(
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller:pageController,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 12.w
                                    ),
                                    child: GridView.builder(
                                        physics: const AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics()
                                        ),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          // number of items per row
                                          crossAxisCount: 5,
                                          childAspectRatio: 0.8,
                                          // vertical spacing between the items
                                          mainAxisSpacing: 10,
                                          // horizontal spacing between the items
                                          crossAxisSpacing: 10,
                                        ),
                                        itemCount: state.gifts.length,
                                        itemBuilder: (BuildContext ctx, index) {

                                          return InkWell(
                                            onTap: (){
                                              giftId=state.gifts[index].id!;

                                              setState((){});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:Border.all(
                                                  color:giftId==state.gifts[index].id!?ColorManager.primaryColor:
                                                  ColorManager.backgroundColor,
                                                ),
                                                borderRadius: BorderRadius.circular(12.w),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CachedNetworkImage(

                                                      imageUrl: state.gifts[index].img!,
                                                      width: 33.w,
                                                      height: 33.w,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                                    SizedBox(height: 6.h,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset('assets/icons/diamonds.svg',
                                                            width: 14.w),
                                                        const SizedBox(width: 3,),
                                                        Text(state.gifts[index].price??'0',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily: 'DIN',
                                                            fontWeight: FontWeight.w500,
                                                            color:ColorManager.backgroundColor,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                        ),

                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 12.w
                                    ),
                                    child: GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          // number of items per row
                                          crossAxisCount: 5,
                                          childAspectRatio: 0.8,
                                          // vertical spacing between the items
                                          mainAxisSpacing: 10,
                                          // horizontal spacing between the items
                                          crossAxisSpacing: 10,
                                        ),
                                        itemCount: state.flags.length,
                                        itemBuilder: (BuildContext ctx, index) {

                                          return InkWell(
                                            onTap: (){
                                              giftId=state.flags[index].id!;
                                              setState((){});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:Border.all(
                                                  color:giftId==state.flags[index].id!?ColorManager.primaryColor:
                                                  ColorManager.backgroundColor,
                                                ),
                                                borderRadius: BorderRadius.circular(12.w),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CachedNetworkImage(

                                                      imageUrl: state.flags[index].img!,
                                                      width: 33.w,
                                                      height: 33.w,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                                    SizedBox(height: 6.h,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset('assets/icons/diamonds.svg',
                                                            width: 14.w),
                                                        const SizedBox(width: 3,),
                                                        Text(state.flags[index].price??'0',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily: 'DIN',
                                                            fontWeight: FontWeight.w500,
                                                            color:ColorManager.backgroundColor,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                        ),

                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 12.w
                                    ),
                                    child: GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          // number of items per row
                                          crossAxisCount: 5,
                                          childAspectRatio: 0.8,
                                          // vertical spacing between the items
                                          mainAxisSpacing: 10,
                                          // horizontal spacing between the items
                                          crossAxisSpacing: 10,
                                        ),
                                        itemCount: state.rich.length,
                                        itemBuilder: (BuildContext ctx, index) {

                                          return InkWell(
                                            onTap: (){
                                              giftId=state.rich[index].id!;
                                              setState((){});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:Border.all(
                                                  color:giftId==state.rich[index].id!?ColorManager.primaryColor:
                                                  ColorManager.backgroundColor,
                                                ),
                                                borderRadius: BorderRadius.circular(12.w),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CachedNetworkImage(

                                                      imageUrl: state.rich[index].img!,
                                                      width: 33.w,
                                                      height: 33.w,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                                    SizedBox(height: 6.h,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset('assets/icons/diamonds.svg',
                                                            width: 14.w),
                                                        const SizedBox(width: 3,),
                                                        Text(state.rich[index].price!,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily: 'DIN',
                                                            fontWeight: FontWeight.w500,
                                                            color:ColorManager.backgroundColor,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                        ),

                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 12.w
                                    ),
                                    child: GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          // number of items per row
                                          crossAxisCount: 5,
                                          childAspectRatio: 0.8,
                                          // vertical spacing between the items
                                          mainAxisSpacing: 10,
                                          // horizontal spacing between the items
                                          crossAxisSpacing: 10,
                                        ),
                                        itemCount: state.vip.length,
                                        itemBuilder: (BuildContext ctx, index) {

                                          return InkWell(
                                            onTap: (){
                                              giftId=state.vip[index].id!;
                                              setState((){});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:Border.all(
                                                  color:giftId==state.vip[index].id!?ColorManager.primaryColor:
                                                  ColorManager.backgroundColor,
                                                ),
                                                borderRadius: BorderRadius.circular(12.w),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CachedNetworkImage(

                                                      imageUrl: state.vip[index].img??'',
                                                      width: 33.w,
                                                      height: 33.w,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context, url) =>
                                                      const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) =>
                                                      const Icon(Icons.error),
                                                    ),
                                                    SizedBox(height: 6.h,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset('assets/icons/diamonds.svg',
                                                            width: 14.w),
                                                        const SizedBox(width: 3,),
                                                        Text(state.vip[index].price??'0',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily: 'DIN',
                                                            fontWeight: FontWeight.w500,
                                                            color:ColorManager.backgroundColor,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                        ),

                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 12.w
                                    ),
                                    child: GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          // number of items per row
                                          crossAxisCount: 5,
                                          childAspectRatio: 0.8,
                                          // vertical spacing between the items
                                          mainAxisSpacing: 10,
                                          // horizontal spacing between the items
                                          crossAxisSpacing: 10,
                                        ),
                                        itemCount: state.featured.length,
                                        itemBuilder: (BuildContext ctx, index) {

                                          return InkWell(
                                            onTap: (){
                                              giftId=state.featured[index].id!;
                                              setState((){});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:Border.all(
                                                  color:giftId==state.featured[index].id!?ColorManager.primaryColor:
                                                  ColorManager.backgroundColor,
                                                ),
                                                borderRadius: BorderRadius.circular(12.w),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CachedNetworkImage(

                                                      imageUrl: state.featured[index].img!,
                                                      width: 33.w,
                                                      height: 33.w,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                                    SizedBox(height: 6.h,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset('assets/icons/diamonds.svg',
                                                            width: 14.w),
                                                        const SizedBox(width: 3,),
                                                        Text(state.featured[index].price??'0',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily: 'DIN',
                                                            fontWeight: FontWeight.w500,
                                                            color:ColorManager.backgroundColor,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                        ),

                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 12.w
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icons/diamonds.svg',
                                          width: 14.w),
                                      const SizedBox(width: 3,),
                                      Text(Global.userDiamond!,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: 'DIN',
                                          fontWeight: FontWeight.w500,
                                          color:ColorManager.backgroundColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),

                                    ],
                                  ),

                                  Container(

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.w),
                                        border: Border.all(
                                            color: const Color(0xffD6D6D6)
                                        )
                                    ),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [

                                        GestureDetector(
                                          onTap: (){
                                              if(selected>-1&& giftId>-1)
                                                {
                                                  bloc.onSendGiftEvent(receiverId, roomId, giftId);
                                                  Navigator.pop(context);
                                                }
                                              else{
                                                Fluttertoast.showToast(
                                                    msg: 'please select the gift and the person Who do you want to send a gift to him? '.tr(),
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: ColorManager.primaryColor,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.w,
                                                ),
                                                color:ColorManager.primaryColor,
                                            ),

                                            child: Padding(
                                              padding:  EdgeInsets.symmetric(
                                                  vertical: 8.h,
                                                  horizontal: 20.w

                                              ),
                                              child: Text('Send',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: 'DIN',
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorManager.backgroundColor

                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ).tr(),
                                            ),
                                          ),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),


                          ],
                        ),
                      ),
                );
              },
            ),
          ));
}