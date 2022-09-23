import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/values_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData(
    // main colors
      primaryColor: ColorManager.primaryColor,
      primaryColorLight: ColorManager.primaryColorLight,
      disabledColor: ColorManager.textColor,
      primaryColorDark: ColorManager.darkBackgroundColor,
    hoverColor:Colors.grey.shade200 ,
    hintColor: ColorManager.hintText,
    scaffoldBackgroundColor:  ColorManager.backgroundColor,

   cursorColor:const Color(0xffB7B7B7),
   fontFamily: 'DIN',
    // cardview theme
      cardTheme: const CardTheme(
      color:  ColorManager.lightTextColor,
      shadowColor: ColorManager.hintText,
      elevation: 4),
    // app bar theme

    // button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                  color: ColorManager.lightTextColor, fontSize: FontSize.s17),
              primary: ColorManager.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12))))
    // text theme
      ,textTheme: TextTheme(
      subtitle1: getMediumStyle(
          color: ColorManager.hintText, fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.lightGreyShade200),
      bodyText1: getRegularStyle(color: ColorManager.lightGreyShade200)),
    // input decoration theme (text form field)


  );
}
ThemeData getApplicationDarkTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.darkPrimary,
    primaryColorLight: ColorManager.darkPrimaryLight,
    disabledColor: ColorManager.backgroundColor,
    scaffoldBackgroundColor: const Color(0xff1D1D1D),
    primaryColorDark: ColorManager.backgroundColor,
    hoverColor:Colors.grey.shade700 ,
    hintColor: ColorManager.hintText,
    cursorColor: Colors.grey.shade200,

    fontFamily: 'DIN',
    // cardview theme
    cardTheme: const CardTheme(
        color:  ColorManager.lightGreyShade200,
        shadowColor: ColorManager.hintText,
        elevation: 4),
    // app bar theme

    // button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.lightTextColor, fontSize: FontSize.s17),
            primary: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12))))
    // text theme
    ,textTheme: TextTheme(
      subtitle1: getMediumStyle(
          color: ColorManager.hintText, fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.textColor,),
      bodyText1: getRegularStyle(color: ColorManager.lightGreyShade200)),
    // input decoration theme (text form field)


  );
}