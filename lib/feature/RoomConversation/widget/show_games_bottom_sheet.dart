import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/feature/RoomConversation/widget/music/show_music_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<String?> showGamesBottomSheet(BuildContext ctx) async {
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
      builder: (ctx) => Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: const BoxDecoration(
              color: ColorManager.darkBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.center,
            width: 1.sw,
            height: 350.h,
            child: Column(

              children: [
               Column(
                 children: [ Row(
                   children: [
                     Text(
                       "Games".tr(),
                       style: TextStyle(
                           fontSize: 18.sp,
                           fontWeight: FontWeight.bold,
                           color: ColorManager.backgroundColor),
                     ),
                   ],
                 ),
                   SizedBox(
                     height: 5.h,
                   ),
                   Row(
                     children: [
                       Column(
                         children: [
                           Container(
                             color: ColorManager.darkBackgroundColor,
                             height: 40.h,
                             width: 40.w,
                             child: SvgPicture.asset(
                               "assets/icons/dice.svg",
                               height: 40.h,
                               width: 40.w,
                             ),
                           ),
                           Text("Dice Game".tr(),style: TextStyle(
                               fontSize: 12.sp,
                               color: ColorManager.hintText
                           ),)
                         ],
                       ),
                       SizedBox(width: 10.w,),
                       Column(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 color: Colors.black87,
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(color: ColorManager.hintText)
                             ),
                             alignment: Alignment.center,
                             height: 40.h,
                             width: 40.w,
                             child: SvgPicture.asset(
                               "assets/icons/123_numbers.svg",
                               height: 25.h,
                               width: 25.w,
                               color: ColorManager.backgroundColor,
                             ),
                           ),
                           Text("Numbers Game".tr(),style: TextStyle(
                               fontSize: 12.sp,
                               color: ColorManager.hintText
                           ),)
                         ],
                       ),
                     ],
                   ),],
               ),
                SizedBox(height: 40.h,),
                Column(
                  children: [ Row(
                    children: [
                      Text(
                        "Entertainment".tr(),
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.backgroundColor),
                      ),
                    ],
                  ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(ctx);
                                showMusicBottomSheet(ctx);
                                },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: ColorManager.hintText)
                                ),
                                alignment: Alignment.center,
                                height: 40.h,
                                width: 40.w,
                                child: SvgPicture.asset(
                                  "assets/icons/music.svg",
                                  height: 25.h,
                                  width: 25.w,
                                  color: ColorManager.backgroundColor,
                                ),
                              ),
                            ),
                            Text("music".tr(),style: TextStyle(
                                fontSize: 12.sp,
                                color: ColorManager.hintText
                            ),)
                          ],
                        ),
                      ],
                    ),],
                ),

              ],
            ),
          ));
}
