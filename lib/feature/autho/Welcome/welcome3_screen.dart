import 'package:chato/Preference.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/core/utils/values_manager.dart';
import 'package:chato/feature/autho/login/login_screen.dart';
import 'package:chato/feature/autho/register/register_screen.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome3Screen extends StatefulWidget {
  const Welcome3Screen({Key? key}) : super(key: key);

  @override
  _Welcome3ScreenState createState() => _Welcome3ScreenState();
}

class _Welcome3ScreenState extends State<Welcome3Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: 1.sh,
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20.w, vertical: AppPadding.p40.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 215.w,
                      child: Text(
                        "Group and individual conversations".tr(),
                        textAlign: TextAlign.center,
                        style: getLightStyle(
                            fontSize: FontSize.s22,
                            color: ColorManager.primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Talk to whoever you want, how you want".tr(),
                      style: getLightStyle(
                          fontSize: FontSize.s18,
                          color: ColorManager.hintText),
                    ),
                  ],
                ),

                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.w),
                  height: 270.h,
                  width: double.infinity,
                  child: SvgPicture.asset(SvgManger.welcome3_1,
                      width: double.infinity),
                ),

                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    Preferences.saveIsFirstTime(false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (
                          context) => const LoginScreen()),
                    );
                  },
                      child: Text("Start", style: getMediumStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.lightTextColor),).tr()),
                ),

                SizedBox(
                  height: 30.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCircle(ColorManager.backgroundColor),
                      buildCircle(ColorManager.backgroundColor),
                      buildCircle(ColorManager.primaryColor)
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container buildCircle(Color color) {
    return Container(
      margin: EdgeInsets.all(2.w),
      height: 9.h,
      width: 9.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border:
          Border.all(width: 0.4, color: ColorManager.lightGreyShade400)),
    );
  }
}
