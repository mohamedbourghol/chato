
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

void showMenuBottomSheetEmailOne(BuildContext ctx) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Theme
          .of(ctx)
          .scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        side: BorderSide(
            color: Global.darkMode
                ? ColorManager.hintText
                : ColorManager.darkBackgroundColor,
            width: 2),
      ),
      builder: (ctx) =>
          Container(
            width: 1.sw,
            height: 200.h,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Column(
              children: [
                Text(
                  "Email edit".tr(),
                  style: getRegularStyle(
                      color: ColorManager.primaryColor, fontSize: 16.sp),
                ),
                Divider(
                  height: 40.h,
                  color: Global.darkMode
                      ? ColorManager.hintText
                      : ColorManager.textColor,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ahmed.r@hotmail.com",
                      style: getMediumStyle(
                          color: Global.darkMode
                              ? ColorManager.hintText
                              : ColorManager.textColor,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.edit,
                          size: 20.h,
                          color: ColorManager.primaryColor,
                        ))
                  ],
                )
              ],
            ),
          ));
}

void showMenuBottomSheetEmailTwo(BuildContext ctx) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Theme
          .of(ctx)
          .scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        side: BorderSide(
            color: Global.darkMode
                ? ColorManager.hintText
                : ColorManager.darkBackgroundColor,
            width: 2),
      ),
      builder: (ctx) =>
          KeyboardVisibilityBuilder(
           builder: (p0, isKeyboardVisible) {
             return Container(
               width: 1.sw,
               height:isKeyboardVisible?850.h: 350.h,
               alignment: Alignment.topCenter,
               padding: EdgeInsets.symmetric(vertical: 15.h),
               child: Column(
                 children: [
                   Text(
                     "Email edit".tr(),
                     style: getRegularStyle(
                         color: ColorManager.primaryColor, fontSize: 16.sp),
                   ),
                   Divider(
                     height: 40.h,
                     color: Global.darkMode
                         ? ColorManager.hintText
                         : ColorManager.textColor,
                     thickness: 1,
                   ),
                   Column(
                     children: [
                       Text(
                         "Enter passCode to change email".tr(),
                         style: getRegularStyle(
                             color: Global.darkMode
                                 ? ColorManager.hintText
                                 : ColorManager.textColor,
                             fontSize: 16.sp),
                       ),
                       SizedBox(height: 50.h,),
                       SizedBox(
                           height: 75.h,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               PinCodeTextField(
                                 pinTextStyle: getLightStyle(
                                     color: ColorManager.textColor,
                                     fontSize: 25.sp),
                                 defaultBorderColor: Global.darkMode
                                     ? ColorManager.hintText
                                     : ColorManager.primaryColor,
                                 hasTextBorderColor: Global.darkMode
                                     ? ColorManager.hintText
                                     : ColorManager.primaryColor,
                                 pinBoxRadius: 30,
                                 pinBoxWidth: 45.w,
                                 pinBoxHeight: 70.h,
                                 pinBoxBorderWidth: 1,

                               ),
                             ],
                           )),
                       SizedBox(height: 30.h,),
                       SizedBox(
                         height: 45.h,
                         width: 175.w,
                         child: ElevatedButton(onPressed: () {},
                             child: Text("Confirm".tr(), style: getRegularStyle(color:ColorManager.backgroundColor,))),
                       )
                     ],
                   )
                 ],
               ),
             );
           } ,

          ));
}

void showMenuBottomSheetEmailThree(BuildContext ctx) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Theme
          .of(ctx)
          .scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        side: BorderSide(
            color: Global.darkMode
                ? ColorManager.hintText
                : ColorManager.darkBackgroundColor,
            width: 2),
      ),
      builder: (ctx) =>
          KeyboardVisibilityBuilder(
            builder: (p0, isKeyboardVisible) {
              return Container(
                width: 1.sw,
                height:isKeyboardVisible?850.h: 350.h,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Column(
                  children: [
                    Text(
                      "Email edit".tr(),
                      style: getRegularStyle(
                          color: ColorManager.primaryColor, fontSize: 16.sp),
                    ),
                    Divider(
                      height: 40.h,
                      color: Global.darkMode
                          ? ColorManager.hintText
                          : ColorManager.textColor,
                      thickness: 1,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          height: 45.h,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: FontSize.s16,
                                color: Global.darkMode
                                    ? ColorManager.backgroundColor
                                    : ColorManager.textColor),

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                              hintText: "Enter your email".tr(),
                              hintStyle: TextStyle(
                                color: ColorManager.hintText,
                                fontSize: 14.sp,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Global.darkMode
                                          ? ColorManager.backgroundColor
                                          : ColorManager.textColor)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: ColorManager.hintText)),
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: ColorManager.hintText),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return tr('Enter a valid email',);
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        SizedBox(
                          height: 45.h,
                          width: 175.w,
                          child: ElevatedButton(onPressed: () {},
                              child: Text("Send code".tr(), style: getRegularStyle(color:ColorManager.backgroundColor,))),
                        )
                      ],
                    )
                  ],
                ),
              );
            } ,

          ));
}

void showMenuBottomSheetEmailFour(BuildContext ctx, TextEditingController tec) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Theme
          .of(ctx)
          .scaffoldBackgroundColor,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        side: BorderSide(
            color: Global.darkMode
                ? ColorManager.hintText
                : ColorManager.darkBackgroundColor,
            width: 2),
      ),
      builder: (ctx) =>
          KeyboardVisibilityBuilder(
            builder: (p0, isKeyboardVisible) {
              return Container(
                width: 1.sw,
                height:isKeyboardVisible?850.h: 350.h,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Column(
                  children: [
                    Text(
                      "Email edit".tr(),
                      style: getRegularStyle(
                          color: ColorManager.primaryColor, fontSize: 16.sp),
                    ),
                    Divider(
                      height: 40.h,
                      color: Global.darkMode
                          ? ColorManager.hintText
                          : ColorManager.textColor,
                      thickness: 1,
                    ),
                    Column(
                      children: [
                        Text(
                          "Enter passCode to change email".tr(),
                          style: getRegularStyle(
                              color: Global.darkMode
                                  ? ColorManager.hintText
                                  : ColorManager.textColor,
                              fontSize: 16.sp),
                        ),
                        SizedBox(height: 50.h,),
                        SizedBox(
                            height: 75.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PinCodeTextField(
                                  pinTextStyle: getLightStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 25.sp),
                                  defaultBorderColor: Global.darkMode
                                      ? ColorManager.hintText
                                      : ColorManager.primaryColor,
                                  hasTextBorderColor: Global.darkMode
                                      ? ColorManager.hintText
                                      : ColorManager.primaryColor,
                                  pinBoxRadius: 30,
                                  pinBoxWidth: 45.w,
                                  pinBoxHeight: 70.h,
                                  pinBoxBorderWidth: 1,
                                  controller: tec,
                                ),
                              ],
                            )),
                        SizedBox(height: 30.h,),
                        SizedBox(
                          height: 45.h,
                          width: 175.w,
                          child: ElevatedButton(onPressed: () {},
                              child: Text("Confirm", style: getRegularStyle(color:ColorManager.backgroundColor,))),
                        )
                      ],
                    )
                  ],
                ),
              );
            } ,

          ));
}
