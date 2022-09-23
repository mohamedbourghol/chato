import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/feature/autho/forgot/bloc/forget_bloc.dart';
import 'package:chato/feature/autho/forgot/bloc/forget_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../login/login_screen.dart';



class ConfirmScreenSecond extends StatefulWidget {
  final ForgetBloc bloc;
  final String code;
  final String email;
  const ConfirmScreenSecond({Key? key,
    required this.bloc,
    required this.email,
    required this.code
  }) : super(key: key);

  @override
  _ConfirmScreenSecondState createState() => _ConfirmScreenSecondState();
}

class _ConfirmScreenSecondState extends State<ConfirmScreenSecond> {
      TextEditingController passwordEditingController=
          TextEditingController(
            text: ''
          );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetBloc,ForgetState>(
      listener: (context, state) {
        if(state.changePasswordModel!.status!=null)
          {
            if(state.changePasswordModel!.status!)
              {
                Fluttertoast.showToast(
                    msg: state.changePasswordModel!.message!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: ColorManager.primaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                const LoginScreen()), (Route<dynamic> route) => false);
              }
            else
              {
                Fluttertoast.showToast(
                    msg: state.changePasswordModel!.message!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: ColorManager.primaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
          }
      },
      bloc: widget.bloc,
      builder: (context, state) {
        return SafeArea(child: Scaffold(
          body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 150.h,),
                  Text(
                    "Enter New Password".tr(),
                    style: getRegularStyle(
                      color:Global.darkMode?ColorManager.backgroundColor: ColorManager.textColor,
                      fontSize: 21.sp,
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  SizedBox(height: 45.h,
                    child: TextFormField(
                      controller: passwordEditingController,
                      decoration: InputDecoration(
                          contentPadding:EdgeInsets.only(top: 5.h,right: 10.w,left: 10.w) ,
                          hintStyle: getRegularStyle(color: ColorManager.hintText,fontSize:FontSize.s14 ),
                          hintText: "Password".tr(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: ColorManager.hintText
                              )
                          )
                          ,border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:const BorderSide(
                              color: ColorManager.hintText
                          )

                      )
                      ),
                    ),
                  ),
                  SizedBox(height: 80.h,),
                  SizedBox(
                      height: 45.h,
                      width: 335.w,
                      child: ElevatedButton(
                        onPressed: () {
                          if(passwordEditingController.text.length>8)
                            {
                              widget.bloc.onChangePasswordEvent
                                (password: passwordEditingController.text
                                ,code: widget.code,
                                email: widget.email
                              );
                            }
                          else{
                            Fluttertoast.showToast(
                                msg: "Password must be more than 8 characters".tr(),
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
                              color: ColorManager.lightTextColor,
                              fontSize: 15.sp),
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
