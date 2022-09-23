
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../bloc/room_conversation_bloc.dart';

Future<void> showMenuBottomSheetRocket(BuildContext ctx,
     RoomConversationBloc bloc,
      int roomId
    ) async {
    TextEditingController textEditingController=
    TextEditingController(text: '');


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
            height: 400.h,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Add Trend".tr(),
                        style: getRegularStyle(
                            color: ColorManager.primaryColor, fontSize: 16.sp),
                       textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 40.h,
                  color: Global.darkMode
                      ? ColorManager.hintText
                      : ColorManager.textColor,
                  thickness: 1,
                ),

                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],



                    style: TextStyle(
                        fontSize: FontSize.s16,
                        color:Global.darkMode? ColorManager.backgroundColor:
                            ColorManager.textColor
                            ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                      hintText: "number of lifts".tr(),
                      hintStyle: TextStyle(
                        color: ColorManager.hintText,
                        fontSize: 14.sp,
                      ),
                      icon: Icon(
                        Icons.money,
                        size: 18.w,
                        color: ColorManager.hintText,
                      ),
                      disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.hintText)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorManager.backgroundColor
                                  )),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.hintText)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return tr('Enter a password');
                      }
                      else if(value.length<8) {
                        return tr('Password is short'.tr());
                      }

                      return null;
                    },
                  ),
                ),


                SizedBox(
                  height: 15.h,
                ),
                if(textEditingController.text.isNotEmpty)
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.0.w),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((int.tryParse(textEditingController.text)!*1500).toString(),
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      SvgPicture.asset('assets/icons/coins.svg',
                      width: 22.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 65.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 16.w
                  ),
                  child: SizedBox(
                      height: 45.h,

                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey;
                                }
                                else {
                                  return  ColorManager.primaryColor;
                                }
                                // Use the component's default.
                              },
                            ),),
                        onPressed:textEditingController.text.isNotEmpty? () {
                            print(Global.userCoins);
                           if((double.tryParse(textEditingController.text)!*1500)
                               <=double.tryParse(Global.userCoins!)!) {
                             bloc.onAddTrendEvent(
                                 roomId:roomId ,
                              count: int.tryParse(textEditingController.text)!,
                              payment: ((double.tryParse(textEditingController.
                                 text)!*1500).toString()),
                               );
                             Navigator.pop(ctx);
                           }
                           else{
                             Fluttertoast.showToast(
                                 msg: "There is not enough balance".tr(),
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM,
                                 timeInSecForIosWeb: 1,
                                 backgroundColor: ColorManager.primaryColor,
                                 textColor: Colors.white,
                                 fontSize: 16.0
                             );
                           }


                        }:null,
                        child: Text(
                          "Send".tr(),
                          style: getRegularStyle(
                              color: ColorManager.lightTextColor,
                              fontSize: 15.sp),
                        ),
                      )),
                ),

              ],
            ),
          ));
}

void showMenuBottomSheetEmailTwo(BuildContext ctx, TextEditingController tec) {
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

void showMenuBottomSheetEmailThree(BuildContext ctx, TextEditingController tec) {
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
                            controller: tec,
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
