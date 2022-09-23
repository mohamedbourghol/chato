
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/feature/Pages/ProfilePage/bloc/prof_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_utils/keyboard_aware/keyboard_aware.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../../core/utils/values_manager.dart';
import '../bloc/prof_bloc.dart';

void showBottomSheetPassword(BuildContext ctx,
    ProfBloc bloc
    ) {
  final _formKey = GlobalKey<FormState>();
   bloc.onResetParamEvent();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
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
          BlocBuilder<ProfBloc,ProfState>(
            bloc: bloc,
            builder: (context, state) {
              return KeyboardAware(
                builder: (context, keyboardConfig) {
                 return Container(
                    width: 1.sw,
                    height: 400.h+keyboardConfig.keyboardHeight,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child:state.isLoadingChange!?
                    const Center(child:
                    CircularProgressIndicator()):
                    state.resetModel.message!.isNotEmpty?
                    Center(child:
                    Text(state.resetModel.message!,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).primaryColorDark

                      ),
                    )):
                        state.error!.isNotEmpty?
                        Center(child:
                        Text(state.error!,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Theme.of(context).primaryColorDark

                          ),
                        )):
                    ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Change Password".tr(),
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
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppPadding.p16.w, horizontal: AppPadding.p20.w),
                            child: Column(
                              children: [

                                SizedBox(height: 10.h,),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  height: 45.h,
                                  child: TextFormField(
                                    controller: oldPasswordController,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                                      hintText: "Old Password".tr(),

                                      hintStyle: TextStyle(
                                        color: ColorManager.hintText,
                                        fontSize: 14.sp,
                                      ),
                                      icon: Icon(
                                        Icons.lock_outline,
                                        size: 18.w,
                                        color: ColorManager.hintText,
                                      ),
                                      disabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorManager.hintText)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Global.darkMode
                                                  ? ColorManager.backgroundColor
                                                  : ColorManager.textColor)),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorManager.hintText)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return tr('Enter a valid password',);
                                      }
                                      return null;
                                    },

                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  height: 45.h,
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                                      hintText: "Password".tr(),
                                      hintStyle: TextStyle(
                                        color: ColorManager.hintText,
                                        fontSize: 14.sp,
                                      ),
                                      icon: Icon(
                                        Icons.lock_outline,
                                        size: 18.w,
                                        color: ColorManager.hintText,
                                      ),
                                      disabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorManager.hintText)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Global.darkMode
                                                  ? ColorManager.backgroundColor
                                                  : ColorManager.textColor)),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorManager.hintText)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return tr('Enter a password');
                                      }
                                      else if(value.length<8) {
                                        return tr('Password is short');
                                      }
                                      else if(confirmPasswordController.text!=
                                          passwordController.text)
                                      {
                                        return tr('passwords do not match');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  height: 45.h,
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                                      hintText: "Confirm Password".tr(),
                                      hintStyle: TextStyle(
                                        color: ColorManager.hintText,
                                        fontSize: 14.sp,
                                      ),
                                      icon: Icon(
                                        Icons.lock_outline,
                                        size: 18.w,
                                        color: ColorManager.hintText,
                                      ),
                                      disabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorManager.hintText)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Global.darkMode
                                                  ? ColorManager.backgroundColor
                                                  : ColorManager.textColor)),
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
                                      else if(confirmPasswordController.text!=
                                          passwordController.text)
                                      {
                                        return tr('passwords do not match');
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                    height: 45.h,
                                    width: 335.w,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          //  bloc.onRegisterAccountEvent(
                                          //  name: nameController.text,
                                          //  email: emailController.text,
                                          //  password: passwordController.text,
                                          //  passwordConfirm: confirmPasswordController.text);
                                          bloc.onChangePasswordEvent(oldPasswordController.text,
                                              passwordController.text,
                                              confirmPasswordController.text);
                                        }
                                      },
                                      child: Text(
                                        "Change Password".tr(),
                                        style: getRegularStyle(
                                            color: ColorManager.lightTextColor,
                                            fontSize: 15.sp),
                                      ),
                                    )),
                                SizedBox(
                                  height: 15.h,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },

              );
            },

          ));
}



