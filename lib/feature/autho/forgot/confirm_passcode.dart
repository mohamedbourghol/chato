import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/feature/autho/forgot/bloc/forget_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'bloc/forget_bloc.dart';
import 'confirm_passcode_second.dart';

class ConfirmScreen extends StatefulWidget {
  final ForgetBloc bloc;
  const ConfirmScreen({Key? key,required this.bloc}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController pin1Controller = TextEditingController();

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetBloc,ForgetState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric( horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 275.h,
                            width: 275.w,
                            child: Image.asset(
                              SvgManger.confirm,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Enter PassCode".tr(),
                        style: getMediumStyle(
                          color: Global.darkMode
                              ? ColorManager.backgroundColor
                              : ColorManager.textColor,
                          fontSize: 21.sp,
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        "Enter the code you got in your email".tr(),
                        style: getRegularStyle(
                            color: ColorManager.hintText, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                          height: 75.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PinCodeTextField(

                                pinTextStyle: getLightStyle(
                                    color: ColorManager.textColor, fontSize: 25.sp),
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
                                controller: pin1Controller,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                          height: 45.h,
                          width: 335.w,
                          child: ElevatedButton(
                            onPressed: () {

                              if(state.forgetPasswordModel!.data!.code
                                  ==int.parse(pin1Controller.text))
                                {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        ConfirmScreenSecond(
                                        bloc: widget.bloc,
                                          code: state.forgetPasswordModel!.data!.code!.toString(),
                                          email: state.forgetPasswordModel!.data!.email!
                                        )),);
                                }
                              else{
                                Fluttertoast.showToast(
                                    msg: "Invalid code entered".tr(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorManager.primaryColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                            },
                            child: Text(
                              "Confirm".tr(),
                              style: getRegularStyle(
                                  color: ColorManager.lightTextColor, fontSize: 15.sp),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ));
      },

    );
  }
}
