import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/core/utils/values_manager.dart';
import 'package:chato/feature/autho/forgot/forgot_screen.dart';
import 'package:chato/feature/autho/login/bloc/login_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../injection.dart';
import '../../Pages/pages_screen.dart';
import '../register/register_screen.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var checkBoxValue = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBloc bloc = sl<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.loginModel!.data != null) {
            if (state.loginModel!.data!.token!.isNotEmpty) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const PagesScreen(pageNumber: 0),
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
              title: tr('login error'),
              desc: state.error,
              btnCancelText: tr('ok'),
              btnCancelOnPress: () {},
            ).show();
          }
          else if (state.loginModel!.message != null) {
            if (state.loginModel!.message!.isNotEmpty) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: tr('login error'),
                desc: tr("${state.loginModel!.message}"),
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
                          color: Global.darkMode
                              ? ColorManager.lightGreyShade400
                              : null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(
                                      SvgManger.log1,
                                      width: 222.w,
                                      height: 195.h,
                                    ),
                                  ],
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
                    "Welcome Back".tr(),
                    style: getLightStyle(
                        color: Global.darkMode
                            ? ColorManager.backgroundColor
                            : ColorManager.primaryColor,
                        fontSize: 26.sp),
                  ),
                  Text(
                    "Login to enjoy".tr(),
                    style: getLightStyle(
                        color: ColorManager.hintText, fontSize: FontSize.s17),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: AppPadding.p16.w,
                        horizontal: AppPadding.p20.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name".tr(),
                                style: TextStyle(
                                    color: Global.darkMode
                                        ? ColorManager.backgroundColor
                                        : ColorManager.textColor,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4.h),
                            height: 45.h,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: FontSize.s16,
                                  color: Global.darkMode
                                      ? ColorManager.backgroundColor
                                      : ColorManager.textColor),
                              controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 5.h, bottom: 10.h, right: 5, left: 5),
                                hintText: "name".tr(),
                                hintStyle: TextStyle(
                                  color: ColorManager.hintText,
                                  fontSize: 14.sp,
                                ),
                                icon: Icon(
                                  Icons.email_outlined,
                                  size: 18.w,
                                  color: ColorManager.hintText,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.hintText)),
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManager.hintText),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr(
                                    'Enter a valid name'.tr(),
                                  );
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Password".tr(),
                                style: TextStyle(
                                    color: Global.darkMode
                                        ? ColorManager.backgroundColor
                                        : ColorManager.textColor,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4.h),
                            height: 45.h,
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              style: TextStyle(
                                  fontSize: FontSize.s16,
                                  color: Global.darkMode
                                      ? ColorManager.backgroundColor
                                      : ColorManager.textColor),
                              controller: passwordController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 5.h, bottom: 10.h, right: 5, left: 5),
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
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.hintText)),
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManager.hintText),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr('Enter a password');
                                }
                                if (value.length < 8) {
                                  return tr('Password is short');
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ForgotScreen()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                  child: Column(
                                    children: [
                                      Text(
                                        "Privacy Policy".tr(),
                                        style: getRegularStyle(
                                            color: Global.darkMode
                                                ? ColorManager.primaryColor
                                                : ColorManager.primaryColor,
                                            fontSize: 13.sp),
                                      ),
                                      SizedBox(
                                        width: 90.w,
                                        child:  Divider(
                                          height: 0,
                                          thickness: 1,
                                          color:  Global.darkMode
                                              ? ColorManager.primaryColor
                                              : ColorManager.primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "forgot password".tr(),
                                      style: getRegularStyle(
                                          color: Global.darkMode
                                              ? ColorManager.backgroundColor
                                              : ColorManager.hintText,
                                          fontSize: 13.sp),
                                    ),
                                    SizedBox(
                                      width: 90.w,
                                      child: const Divider(
                                        height: 0,
                                        thickness: 1,
                                        color: ColorManager.hintText,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          SizedBox(
                              height: 45.h,
                              width: 335.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    bloc.onLoginAccountEvent(
                                        name: nameController.text,
                                        password: passwordController.text);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: const Text('incomplete data')
                                              .tr()),
                                    );
                                  }
                                },
                                child: Text(
                                  "Login".tr(),
                                  style: getRegularStyle(
                                      color: ColorManager.lightTextColor,
                                      fontSize: 15.sp),
                                ),
                              )),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "do you not have an account?".tr(),
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
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen()),
                                    );
                                  },
                                  child: Text(
                                    "  register".tr(),
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
                  )
                ],
              ),
            )),
          ));
        });
  }
}
