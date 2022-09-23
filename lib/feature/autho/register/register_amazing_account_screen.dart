import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chato/Globals.dart';
import 'package:chato/core/utils/color_manager.dart';
import 'package:chato/core/utils/font_manager.dart';
import 'package:chato/core/utils/styles_manager.dart';
import 'package:chato/core/utils/svg_manager.dart';
import 'package:chato/core/utils/values_manager.dart';
import 'package:chato/feature/autho/register/bloc/register_bloc.dart';
import 'package:chato/feature/autho/register/bloc/register_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:profanity_filter/profanity_filter.dart';
import '../../../injection.dart';



class RegisterAmazingAccountScreen extends StatefulWidget {
  const RegisterAmazingAccountScreen({Key? key}) : super(key: key);

  @override
  _RegisterAmazingAccountScreenState createState() => _RegisterAmazingAccountScreenState();
}

class _RegisterAmazingAccountScreenState extends State<RegisterAmazingAccountScreen> {
  var checkBoxValue = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegisterBloc bloc=sl<RegisterBloc>();
  int cost=0;
  RegExp arbExp =  RegExp(r'^[ء-ي]');
  RegExp enExp = RegExp(r'^[a-zA-Z0-9]');
  RegExp regexEmoji = RegExp(
      r'(?:[\u00A9\u00AE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9-\u21AA\u231A-\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA-\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614-\u2615\u2618\u261D\u2620\u2622-\u2623\u2626\u262A\u262E-\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u2660\u2663\u2665-\u2666\u2668\u267B\u267F\u2692-\u2697\u2699\u269B-\u269C\u26A0-\u26A1\u26AA-\u26AB\u26B0-\u26B1\u26BD-\u26BE\u26C4-\u26C5\u26C8\u26CE-\u26CF\u26D1\u26D3-\u26D4\u26E9-\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733-\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763-\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934-\u2935\u2B05-\u2B07\u2B1B-\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|(?:\uD83C[\uDC04\uDCCF\uDD70-\uDD71\uDD7E-\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01-\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50-\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96-\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F-\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95-\uDD96\uDDA4-\uDDA5\uDDA8\uDDB1-\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDEE0-\uDEE5\uDEE9\uDEEB-\uDEEC\uDEF0\uDEF3-\uDEF6]|\uD83E[\uDD10-\uDD1E\uDD20-\uDD27\uDD30\uDD33-\uDD3A\uDD3C-\uDD3E\uDD40-\uDD45\uDD47-\uDD4B\uDD50-\uDD5E\uDD80-\uDD91\uDDC0]))');


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc,RegisterState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.registerModel!.data!=null) {
          if (state.registerModel!.data!.token!.isNotEmpty) {
            Fluttertoast.showToast(
                msg: state.registerModel!.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.primaryColor,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pop(context);
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
              title: tr('register error'),
              desc: state.registerModel!.message,
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Create Amazing Account".tr(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              cost.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                                color: ColorManager.primaryColor,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            SvgPicture.asset(
                              'assets/icons/diamonds.svg',
                              width: 22.w,
                            ),

                          ],
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
                                    onChanged:(va){
                                       int arab=0;
                                       int en=0;
                                       cost=0;
                                      for(int i=0;i<va.length; i++)
                                        {

                                          if(arbExp.hasMatch(va[i]))
                                            {
                                              arab++;
                                            }
                                          else if(enExp.hasMatch(va[i]))
                                          {
                                            en++;
                                           }
                                        }
                                      if(va.characters.length<4)
                                        {
                                          if(va.characters.isNotEmpty)
                                            {
                                              if(arab>0||en>0)
                                              {
                                                cost=100000;
                                              }
                                              else{
                                                cost=75000;
                                              }
                                            }

                                        }
                                      else{
                                        cost=30000;
                                      }
                                        //   cost=(100000*arab)+(30000*en)+
                                       //    (30000*(va.characters.length-arab-en))+
                                         //  (75000*(va.length-va.characters.length));

                                      setState(() {
                                      });

                                    },
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        color: Global.darkMode
                                            ? ColorManager.backgroundColor
                                            : ColorManager.textColor),

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
                                        onTap: () {},
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
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                              if (states.contains(MaterialState.disabled)) {
                                                return ColorManager.lightGreyShade400;
                                              }

                                              return ColorManager.primaryColor; // Use the component's default.
                                            },
                                          )),
                                      onPressed:() {
                                        final filter =sl<ProfanityFilter> ();
                                        bool hasProfanity=  filter.hasProfanity(nameController.text);
                                        if (_formKey.currentState!.validate()) {
                                          if(!hasProfanity)
                                          {
                                            bloc.onRegisterAmazingAccountEvent(
                                                name: nameController.text,
                                                email: emailController.text,
                                                password: passwordController.text,
                                                passwordConfirm: confirmPasswordController.text,
                                              cost: cost
                                            );
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
