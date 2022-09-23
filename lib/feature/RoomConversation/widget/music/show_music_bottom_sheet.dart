import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/feature/RoomConversation/widget/music/add_music.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showMusicBottomSheet(BuildContext ctx) {
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
                Text(
                  "Music".tr(),
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.backgroundColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 185.h,
                  width: 255.w,
                  child: Image.asset(
                    "assets/icons/music_background.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 38.h,
                    width: 160.w,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          ctx,
                          MaterialPageRoute(builder: (
                              context) => const AddMusic()),
                        );
                      },
                      child: Text(
                        "add music",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: ColorManager.backgroundColor),
                      ),
                    ))
              ],
            ),
          ));
}
