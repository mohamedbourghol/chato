import 'package:chato/Globals.dart';
import 'package:chato/Preference.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/feature/autho/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Pages/pages_screen.dart';
import '../autho/Welcome/welcome1_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds:2)).then((value) {
      Global.userToken= Preferences.getUserToken();
      Global.userId=Preferences.getUserId();
      Global.userImage=Preferences.getUserImage();
      if(Global.userImage!.isEmpty)
        {
          Global.userImage='https://www.room.tecknick.net/WI.jpeg';
        }
      Global.userName=Preferences.getUserName();
      Global.userDiamond=Preferences.getUserDiamond();
      Global.userCoins=Preferences.getUserCoins();
      Global.endVip=Preferences.getVipDate();
      Global.vipId=Preferences.getUserVipId();

        if(Global.endVip!.compareTo(DateTime.now())==-1){
          Global.vipId=0;
        }

      print("Global.vipId");

      print(Global.vipId);

      print("Global.vipId");

      if(Global.userToken!.isNotEmpty)
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PagesScreen(
            pageNumber: 0,
          )),
        );
      }
      else{
        bool? isFirst=Preferences.getIsFirstTime();
        if(isFirst!)
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }

      }
    });


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
               mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                decoration: BoxDecoration(
                    color:Global.darkMode?
                    ColorManager.darkPrimary:ColorManager.backgroundColor ,
                    boxShadow: [
                      BoxShadow(
                        color:Global.darkMode?ColorManager.darkBackgroundColor: ColorManager.lightGreyShade200,
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0,
                            0), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30)),
                height: 120.h,
                width: 120.w,
                child: Center(
                    child: SvgPicture.asset(
                      SvgManger.logo,
                      height: 50.h,
                      width: 65.w,
                      color: Global.darkMode?ColorManager.backgroundColor:null,
                    )),
              ),

              Text(
                "chato",
                style: getLightStyle(
                    fontSize: FontSize.s30,
                    color: Global.darkMode
                        ? ColorManager.backgroundColor
                        : ColorManager
                        .textColor),
              ).tr()
            ],
          ),
        )
    ,
    )
    );
  }
}
