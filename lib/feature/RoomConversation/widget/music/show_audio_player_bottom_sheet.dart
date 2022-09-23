import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/feature/RoomConversation/widget/music/add_music.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showAudioPlayerBottomSheet(BuildContext ctx,bool isPlaying) {

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
                Divider(
                  height: 20.h,
                  color: ColorManager.hintText,
                  thickness: 1,
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemBuilder: (ind, ctx) {
                        return Row(
                          children: [
                            Text(
                              "aud_14141",
                              style: TextStyle(
                                  color: ColorManager.backgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp),
                            ),
                            const Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 42.h,
                                child: const Icon(
                                  Icons.close,
                                  color: ColorManager.backgroundColor,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                          height: 25.h,
                          width: 25.w,
                        ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/icons/next.png",
                            height: 25.h,
                            width: 25.w,
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                            onTap: () {
                            },
                            child: Icon(
                             isPlaying? Icons.pause_circle_filled:Icons.play_circle_fill,
                              size: 40.h,
                              color: ColorManager.backgroundColor,
                            )),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/icons/previous.png",
                            height: 25.h,
                            width: 25.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        child: SvgPicture.asset(
                      "assets/icons/audio_file_128px.svg",
                      height: 25.h,
                      width: 25.w,
                    )),
                  ],
                )
              ],
            ),
          ));
}
