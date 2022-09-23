import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/core/utils/values_manager.dart';
import 'package:chato/feature/Pages/pages_screen.dart';
import 'package:chato/feature/autho/register/bloc/register_bloc.dart';
import 'package:chato/feature/autho/register/bloc/register_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../injection.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var checkBoxValue = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegisterBloc bloc=sl<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc,RegisterState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.registerModel!.data != null) {
          if (state.registerModel!.data!.token!.isNotEmpty) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const PagesScreen(
                   pageNumber: 0,
                ),
              ),
                  (route) => false,
            );
          }
        }
        else if (state.error!.isNotEmpty) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: tr('register error'),
            desc: state.error,
            btnCancelText: tr('ok'),
            btnCancelOnPress: () {},
          ).show();
        }
        else if (state.registerModel!.message != null) {
          if (state.registerModel!.message!.isNotEmpty) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: state.registerModel!.message!,
              desc:tr(state.registerModel!.message!) ,
              btnCancelText: tr('ok'),
              btnCancelOnPress: () {},
            ).show();
          }
        }
      },
      builder: (context, state) {
        return SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: state.isLoading!,
              child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 210.h,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                        SvgManger.register3,
                                        width: 150.w,
                                        height: 160.h,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                SvgManger.register2,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                height: 165.h,
                              ),
                              Image.asset(
                                SvgManger.register1,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                height: 140.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                        SvgManger.register4,
                                        width: 150.w,
                                        height: 170.h,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Create Account".tr(),
                          style: getLightStyle(
                              color: Global.darkMode
                                  ? ColorManager.backgroundColor
                                  : ColorManager.primaryColor,
                              fontSize: 26.sp),
                        ),
                        Text(
                          "join to chato world".tr(),
                          style: getLightStyle(
                              color: ColorManager.hintText, fontSize: FontSize.s17),
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppPadding.p16.w, horizontal: AppPadding.p20.w),
                            child: Column(
                              children: [

                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  height: 45.h,
                                  child: TextFormField(
                                    controller: nameController,
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z.-_]")),
                                    ],
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                                        hintText: "Nickname".tr(),
                                        hintStyle: TextStyle(
                                            color: ColorManager.hintText, fontSize: 14.sp),
                                        icon: Icon(
                                          Icons.person_outline_outlined,
                                          size: 18.w,
                                          color: ColorManager.hintText,
                                        ),
                                        disabledBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: ColorManager.hintText)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Global.darkMode
                                                    ? ColorManager.backgroundColor
                                                    : ColorManager.textColor)),
                                        enabledBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: ColorManager.hintText))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return tr('Enter a valid email',);
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
                                    controller: emailController,
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h,right: 5,left: 5),
                                      hintText: "Email".tr(),
                                      hintStyle: TextStyle(
                                        color: ColorManager.hintText,
                                        fontSize: 14.sp,
                                      ),
                                      icon: Icon(
                                        Icons.email_outlined,
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
                                        return tr('Enter a valid email',);
                                      }
                                      if(!(value.contains('@'))||!(value.contains("com"))) {
                                        return tr("Email isn't correct");
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
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: passwordController,
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
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: confirmPasswordController,
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
                                SizedBox(height: 15.h),

                                Row(
                                  children: [
                                    Container(
                                      height: 19.h,
                                      width: 19.w,
                                      child: Checkbox(
                                          side: BorderSide(
                                            width: 0.5,
                                            color: Global.darkMode
                                                ? ColorManager.backgroundColor
                                                : ColorManager.textColor,
                                          ),
                                          value: checkBoxValue,
                                          activeColor: ColorManager.primaryColor,
                                          onChanged: (newValue) {
                                            setState(() {
                                              checkBoxValue = newValue!;
                                            });
                                          }),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15)),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "I agree to all".tr(),
                                      style: getRegularStyle(
                                          color: Global.darkMode
                                              ? ColorManager.backgroundColor
                                              : ColorManager.textColor,
                                          fontSize: FontSize.s14),
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          const url = "https://room.tecknick.net/Privacy_Policy.text";
                                          if (await canLaunch(url))
                                          // ignore: curly_braces_in_flow_control_structures
                                          await launch(url);
                                          else {
                                          throw "Could not launch $url";
                                          }
                                        },
                                        child: Text(
                                          " terms of use".tr(),
                                          style: getRegularStyle(
                                              color: ColorManager.primaryColor,
                                              fontSize: FontSize.s14),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                    height: 45.h,
                                    width: 335.w,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final filter =sl<ProfanityFilter> ();
                                        bool hasProfanity=  filter.hasProfanity(nameController.text);
                                        if (_formKey.currentState!.validate()) {
                                          if(!hasProfanity)
                                          {
                                            bloc.onRegisterAccountEvent(
                                                name: nameController.text,
                                                email: emailController.text,
                                                password: passwordController.text,
                                                passwordConfirm: confirmPasswordController.text);
                                          }
                                          else{
                                            Fluttertoast.showToast(
                                                msg: 'name contains profanity'.tr(),
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: ColorManager.primaryColor,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }

                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: const Text('incomplete data').tr()),
                                          );
                                        }
                                      },
                                      child: Text(
                                        "Create Account".tr(),
                                        style: getRegularStyle(
                                            color: ColorManager.lightTextColor,
                                            fontSize: 15.sp),
                                      ),
                                    )),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "do you have an account?".tr(),
                                      style: getRegularStyle(
                                          color: Global.darkMode
                                              ? ColorManager.hintText
                                              : ColorManager.textColor,
                                          fontSize: FontSize.s14),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                                          );
                                        },
                                        child: Text(
                                          "   login".tr(),
                                          style: getRegularStyle(
                                              color: Global.darkMode
                                                  ? ColorManager.backgroundColor
                                                  : ColorManager.primaryColor,
                                              fontSize: FontSize.s14),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  )),
            ));
      },

    );
  }
}
