
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/feature/Pages/ProfilePage/bloc/prof_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';



void showMenuBottomSheetEditStatus(BuildContext ctx,
    String state,ProfBloc bloc) {
  TextEditingController textEditingController=TextEditingController(
    text: state
  );
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
                      "Edit Status".tr(),
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
                            controller: textEditingController,
                            style: TextStyle(
                                fontSize: FontSize.s16,
                                color: Global.darkMode
                                    ? ColorManager.backgroundColor
                                    : ColorManager.textColor),

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                              hintText: "Enter your Status".tr(),
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

                          ),
                        ),
                        SizedBox(height: 30.h,),
                        SizedBox(
                          height: 45.h,
                          width: 175.w,
                          child: ElevatedButton(onPressed: () {
                            bloc.onUpdateUserInfoEvent(personalStatus: textEditingController.text);
                            Fluttertoast.showToast(
                                msg: "تم تحديث الحالة",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorManager.primaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            Navigator.pop(ctx);
                          },
                              child: Text("Save".tr(), style: getRegularStyle(color:ColorManager.backgroundColor,))),
                        )
                      ],
                    )
                  ],
                ),
              );
            } ,

          ));
}

