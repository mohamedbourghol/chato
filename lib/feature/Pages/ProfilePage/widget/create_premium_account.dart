import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePremiumAccount extends StatefulWidget {
  const CreatePremiumAccount({Key? key}) : super(key: key);

  @override
  _CreatePremiumAccountState createState() => _CreatePremiumAccountState();
}

class _CreatePremiumAccountState extends State<CreatePremiumAccount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Image.asset(
              "assets/icons/done.png",
              height: 250.h,
              width: 250.w,
            ),
            Text(
                "send done".tr(),
                style: getBoldtStyle(
                    color: Global.darkMode
                        ? ColorManager.lightGreyShade200
                        : ColorManager.textColor,fontSize: 18.sp),),
              SizedBox(
                height: 45.h,
                width: 335.w,
            child: ElevatedButton(
            onPressed: () {
          },
            child: Text(
              "Accept".tr(),
              style: getRegularStyle(
                  color: ColorManager.lightTextColor,
                  fontSize: 15.sp),
            ),
          )),
      ],
    ),)
    ,
    )
    );
  }
}













