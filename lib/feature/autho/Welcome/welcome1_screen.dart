import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/core/utils/values_manager.dart';
import 'package:chato/feature/autho/Welcome/welcome2_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: 1.sh,
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p20.w, vertical: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chato App".tr(),
                      style: getLightStyle(
                          fontSize: FontSize.s30,
                          color: Global.darkMode
                              ? ColorManager.backgroundColor
                              : ColorManager.primaryColor),
                    ),
                    Text(
                      "welcome".tr(),
                      style: getLightStyle(
                          fontSize: FontSize.s20,
                          color: ColorManager.hintText),
                    ),
                  ],
                ),
              ],
            ),

            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.w),
                height: 280.h,
                width: double.infinity,
                child: Image.asset(
                  SvgManger.welcome1_1,
                  fit: BoxFit.fill,
                )),

            SizedBox(
              height: 45.h,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          buildCircle(ColorManager.primaryColor),
                          buildCircle(ColorManager.backgroundColor),
                          buildCircle(ColorManager.backgroundColor)
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                  const Expanded(child: const SizedBox()),
                  InkWell(
                    onTap:(){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Welcome2Screen()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            ColorManager.primaryColor,
                            ColorManager.primaryColorLight
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      width: 104.w,
                      height: 41.h,
                      child: Text("Next".tr(),
                          style: getBoldtStyle(
                            color: ColorManager.lightTextColor,
                            fontSize: FontSize.s16,
                          )),
                    ),
                  )
                ],
              ),
            ),

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
