import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/feature/autho/forgot/bloc/forget_state.dart';
import 'package:chato/feature/autho/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../injection.dart';
import 'bloc/forget_bloc.dart';
import 'confirm_passcode.dart';



class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  ForgetBloc forgetBloc=sl<ForgetBloc>();
  TextEditingController textEditingController=
      TextEditingController(text: '');



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<ForgetBloc,ForgetState>(
          bloc: forgetBloc,
          listener: (context, state) {
              if(state.first!)
                {
                  if(state.forgetPasswordModel!.data!=null)
                  {
                    if(state.forgetPasswordModel!.data!.email!.length>2)
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ConfirmScreen(bloc: forgetBloc,)),
                      );
                    }

                  }
                  else if(state.forgetPasswordModel!.data==null)
                  {
                    Fluttertoast.showToast(
                        msg: state.forgetPasswordModel!.message!,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: ColorManager.primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else if(state.error!.isNotEmpty) {
                    Fluttertoast.showToast(
                        msg: state.error!,
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
          builder:(context, state) {
            return Scaffold(

              body: Container(
                padding: EdgeInsets.symmetric( horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 35.h,),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                         //   Navigator.pop(context);
                           Navigator.pushReplacement(context, MaterialPageRoute(builder:
                            (context) => const LoginScreen(),
                           ));
                          },
                            icon: Icon(
                              Icons.arrow_back_ios,
                             size: 19.w,

                            ))],
                      ),
                      SizedBox(height: 35.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            SvgManger.forgot,
                            height: 165.h,
                            width: 255.w,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      Text(
                        "Changing Password".tr(),
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
                        "Enter your email to change the password".tr(),
                        style: getRegularStyle(
                            color: ColorManager.hintText, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                        height: 45.h,
                        child: TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.only(top: 5.h, right: 10.w, left: 10.w),
                              hintStyle: getRegularStyle(
                                  color: ColorManager.hintText, fontSize: FontSize.s14),
                              hintText: "Email".tr(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: ColorManager.hintText)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  const BorderSide(color: ColorManager.hintText))),
                        ),
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      SizedBox(
                          height: 45.h,
                          width: 335.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                      (states) => Global.darkMode
                                      ? ColorManager.darkBackgroundColor
                                      : ColorManager.primaryColor),
                            ),
                            onPressed: () {

                              forgetBloc.onForgetPasswordEvent(email:
                              textEditingController.text);

                            },
                            child: Text(
                              "Send".tr(),
                              style: getRegularStyle(
                                  color: ColorManager.lightTextColor, fontSize: 15.sp),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },

        ));
  }
}
