
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/feature/Pages/ProfilePage/bloc/prof_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../bloc/prof_bloc.dart';

void showMenuBottomSheetGender(BuildContext ctx,ProfBloc bloc) {
  String gen="male";
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
          BlocConsumer<ProfBloc,ProfState>(
            bloc: bloc,
            listener: (context, state) {
               if(state.isSuccess!)
                 {
                   Navigator.pop(context);
                 }
            },
            builder: (context, state){
              return Container(
                width: 1.sw,
                height: 300.h,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child:state.isLoading!?
                    const Center(
                      child: CircularProgressIndicator(),
                    ):
                Column(
                  children: [
                    Text(
                      "Change Gender".tr(),
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
                    GenderPickerWithImage(

                      showOtherGender: true,
                      verticalAlignedText: true,
                      selectedGender: Gender.Male,
                      selectedGenderTextStyle: const TextStyle(
                          color: ColorManager.primaryColor, fontWeight: FontWeight.bold),
                      unSelectedGenderTextStyle: const TextStyle(
                          color:  ColorManager.primaryColor, fontWeight: FontWeight.normal),
                      onChanged: (Gender? gender) {
                        print(gender!.index);
                        if(gender.index==0)
                        {
                          gen='male';
                        }
                        else if(gender.index==1)
                        {
                          gen='female';
                        }
                        else{
                          gen='other';
                        }
                      },
                      equallyAligned: true,
                      animationDuration: Duration(milliseconds: 300),
                      isCircular: true,
                      // default : true,
                      opacityOfGradient: 0.4,
                      padding: const EdgeInsets.all(3),
                      size: 50, //default : 40
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      width: 0.5.sw,
                      child: ElevatedButton(
                          child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: ColorManager.backgroundColor
                              )
                          ).tr(),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(ColorManager.backgroundColor),
                              backgroundColor: MaterialStateProperty.all<Color>(ColorManager.primaryColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: const BorderSide(color: ColorManager.primaryColor)
                                  )
                              ),
                              padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                                  vertical: 5.h
                              ))
                          ),
                          onPressed: () {
                            bloc.onUpdateUserInfoEvent
                              (gender: gen);
                          }
                      ),
                    ),
                  ],
                ),
              );
            },

          ));
}

